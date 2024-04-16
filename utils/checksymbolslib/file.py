import re
import subprocess

import checksymbolslib.br as br
import checksymbolslib.kconfig as kconfig
import checksymbolslib.makefile as makefile


file_types = [
    kconfig,
    makefile,
]


def get_list_of_files_in_the_repo():
    cmd = ['git', 'ls-files']
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout = p.communicate()[0]
    processed_output = [str(line.decode().rstrip()) for line in stdout.splitlines() if line]
    return processed_output


def get_list_of_files_to_process(all_files):
    files_to_process = []
    for f in all_files:
        if br.file_belongs_to_an_ignored_diretory(f):
            continue
        for t in file_types:
            if t.check_filename(f):
                files_to_process.append(f)
                break
    return files_to_process


def get_list_of_filenames_with_pattern(all_files, exclude_list, pattern):
    re_pattern = re.compile(r'{}'.format(pattern))
    matching_filenames = []
    for filename in all_files:
        if re_pattern.search(filename):
            if filename not in exclude_list:
                matching_filenames.append(filename)
    return matching_filenames


def read_file(filename):
    file_content_raw = []
    with open(filename, 'r', errors='surrogateescape') as f:
        for lineno, text in enumerate(f.readlines()):
            file_content_raw.append([lineno + 1, text])
    return file_content_raw


def cleanup_file_content(file_content_raw):
    cleaned_up_content = []
    continuation = False
    last_line = None
    first_lineno = None
    for cur_lineno, cur_line in file_content_raw:
        if continuation:
            line = last_line + cur_line
            lineno = first_lineno
        else:
            line = cur_line
            lineno = cur_lineno
        continuation = False
        last_line = None
        first_lineno = None
        clean_line = line.rstrip('\n')
        if clean_line.endswith('\\'):
            continuation = True
            last_line = clean_line.rstrip('\\')
            first_lineno = lineno
            continue
        cleaned_up_content.append([lineno, clean_line])
    return cleaned_up_content


def populate_db_from_file(db, filename):
    file_content_raw = read_file(filename)
    file_content_to_process = cleanup_file_content(file_content_raw)
    for t in file_types:
        if t.check_filename(filename):
            t.populate_db(db, filename, file_content_to_process)
