"""Unit tests for utils/generate-cyclonedx."""

import json
import os
import subprocess
import tempfile
import unittest
from pathlib import Path

import infra

PATCH = "support/testing/tests/utils/test_generate_cyclonedx/0001-cve_upstream.patch"
SCHEMA_LICENSES = ["MIT", "Apache-2.0", "GPL-3.0-only"]


class TestGenerateCycloneDX(unittest.TestCase):
    def setUp(self):
        # Provide a fake SPDX schema so the script never hits the network.
        self.schema_dir = tempfile.TemporaryDirectory()
        self.addCleanup(self.schema_dir.cleanup)

        cyclonedx_dir = Path(self.schema_dir.name) / "cyclonedx"
        cyclonedx_dir.mkdir(parents=True)
        schema_path = cyclonedx_dir / "spdx-1.6.schema.json"
        schema_path.write_text(json.dumps({"enum": SCHEMA_LICENSES}))

        self.env = os.environ.copy()
        self.env["BR2_DL_DIR"] = self.schema_dir.name
        self.script = infra.basepath("utils/generate-cyclonedx")
        self.cwd = infra.basepath()

    def _make_show_info(self) -> dict:
        return {
            "package-foo": {
                "name": "foo",
                "version": "1.2",
                "type": "target",
                "virtual": False,
                "licenses": "MIT",
                "cpe-id": "cpe:2.3:a:example:foo:1.2:*:*:*:*:*:*:*",
                "patches": [PATCH],
                "provides": ["package-virtual"],
                "dependencies": ["skeleton-baz", "package-bar"],
                "ignore_cves": ["CVE-2025-0001"],
                "package_dir": "package/package-foo",
            },
            "skeleton-baz": {
                "name": "skeleton-baz",
                "version": "0.1",
                "type": "target",
                "virtual": False,
                "licenses": "Apache-2.0",
                "dependencies": [],
                "package_dir": "package/skeleton-baz",
            },
            "package-bar": {
                "name": "bar",
                "version": "0.2",
                "type": "target",
                "virtual": False,
                "licenses": "MIT",
                "ignore_cves": ["CVE-2025-0002"],
                "dependencies": ["package-virtual"],
                "package_dir": "package/package-bar",
            },
            "host-tool": {
                "name": "host-tool",
                "version": "0.3",
                "type": "host",
                "virtual": False,
                "licenses": "GPL-3.0-only",
                "dependencies": [],
                "package_dir": "package/host-tool",
            },
            "package-virtual": {
                "name": "virtual-provider",
                "virtual": True,
                "type": "target",
                "dependencies": ["package-foo"],
                "package_dir": "package/package-virtual",
            },
        }

    def _run_script(self, extra_args=(), show_info=None):
        data = show_info if show_info is not None else self._make_show_info()
        completed = subprocess.run(
            [self.script, *extra_args],
            cwd=self.cwd,
            env=self.env,
            input=json.dumps(data),
            text=True,
            capture_output=True,
            check=True,
        )
        return json.loads(completed.stdout)

    def _find_component(self, result: dict, name: str) -> dict:
        for component in result["components"]:
            if component["bom-ref"] == name:
                return component
        self.fail(f"component {name} missing")

    def test_default(self):
        result = self._run_script()

        self.assertEqual(len(result["components"]), 4)
        self.assertIn("vulnerabilities", result)
        vulnerabilities = {v["id"]: v for v in result["vulnerabilities"]}
        self.assertEqual(len(vulnerabilities), 2)
        self.assertEqual(vulnerabilities["CVE-2025-0001"]["analysis"]["state"], "resolved_with_pedigree")
        self.assertEqual(vulnerabilities["CVE-2025-0002"]["analysis"]["state"], "in_triage")

        foo = self._find_component(result, "package-foo")
        patch = foo["pedigree"]["patches"][0]
        self.assertIn("text", patch["diff"])
        self.assertIn("content", patch["diff"]["text"])

        host = self._find_component(result, "host-tool")
        self.assertEqual(host["properties"][0]["value"], "host")

        names = {c["bom-ref"] for c in result["components"]}
        self.assertIn("skeleton-baz", names)
        self.assertIn("package-bar", names)
        self.assertNotIn("package-virtual", names)

        foo_deps = next(d for d in result["dependencies"] if d["ref"] == "package-foo")
        self.assertEqual(foo_deps["dependsOn"], ["package-bar", "skeleton-baz"])

        bar_deps = next(d for d in result["dependencies"] if d["ref"] == "package-bar")
        self.assertEqual(bar_deps["dependsOn"], ["package-foo"])

        project_deps = next(d for d in result["dependencies"] if d["ref"] == "buildroot")
        self.assertEqual(project_deps["dependsOn"], ["host-tool", "package-foo"])

    def test_virtual(self):
        result = self._run_script(["--virtual"])

        names = {c["bom-ref"] for c in result["components"]}
        self.assertEqual(names, {"package-foo", "skeleton-baz", "host-tool", "package-virtual", "package-bar"})

        foo_deps = next(d for d in result["dependencies"] if d["ref"] == "package-foo")
        self.assertEqual(foo_deps["dependsOn"], ["package-bar", "skeleton-baz"])

    def test_external_references(self):
        info = self._make_show_info()
        info["package-foo"]["downloads"] = [
            {
                "source": "foo-1.2.tar.gz",
                "uris": [
                    "git+git://git.example.org/foo",
                    "svn+https://svn.example.org/foo",
                    "https+https://sources.buildroot.net/foo",
                    "http|https+https://mirror.example.org/foo",
                ],
            },
        ]

        result = self._run_script(show_info=info)
        foo = self._find_component(result, "package-foo")

        self.assertIn("externalReferences", foo)
        self.assertEqual(
            foo["externalReferences"],
            [
                {
                    "type": "vcs",
                    "url": "git://git.example.org/foo",
                    "comment": "git repository",
                },
                {
                    "type": "vcs",
                    "url": "https://svn.example.org/foo",
                    "comment": "svn repository",
                },
                {
                    "type": "source-distribution",
                    "url": "https://mirror.example.org/foo/foo-1.2.tar.gz",
                }
            ],
        )

    def test_external_references_hashes(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            hash_file = Path(tmpdir) / "foo.hash"
            hash_file.write_text(
                "# source archive checksums\n"
                "sha256 1111111111111111111111111111111111111111111111111111111111111111 foo-1.2.tar.gz\n"
                "sha1 2222222222222222222222222222222222222222 foo-1.2.tar.gz\n"
                "sha256 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa LICENSE\n"
            )

            info = self._make_show_info()
            info["package-foo"]["hashes"] = [str(hash_file)]
            info["package-foo"]["downloads"] = [
                {
                    "source": "foo-1.2.tar.gz",
                    "uris": [
                        "git+git://git.example.org/foo",
                        "http|https+https://mirror.example.org/foo",
                    ],
                },
            ]

            result = self._run_script(show_info=info)

        foo = self._find_component(result, "package-foo")
        self.assertEqual(
            foo["externalReferences"],
            [
                {
                    "type": "vcs",
                    "url": "git://git.example.org/foo",
                    "comment": "git repository",
                    "hashes": [
                        {
                            "alg": "SHA-256",
                            "content": "1111111111111111111111111111111111111111111111111111111111111111",
                        },
                        {
                            "alg": "SHA-1",
                            "content": "2222222222222222222222222222222222222222",
                        },
                    ]
                },
                {
                    "type": "source-distribution",
                    "url": "https://mirror.example.org/foo/foo-1.2.tar.gz",
                    "hashes": [
                        {
                            "alg": "SHA-256",
                            "content": "1111111111111111111111111111111111111111111111111111111111111111",
                        },
                        {
                            "alg": "SHA-1",
                            "content": "2222222222222222222222222222222222222222",
                        },
                    ],
                }
            ],
        )
