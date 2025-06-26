#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gumbo.h>

static void search_for_title(GumboNode* node) {
    if (node->type != GUMBO_NODE_ELEMENT) {
        return;
    }

    if (node->v.element.tag == GUMBO_TAG_TITLE) {
        GumboNode* text = node->v.element.children.data[0];
        if (text->type == GUMBO_NODE_TEXT) {
            printf("Found title: %s\n", text->v.text.text);
        }
        return;
    }

    GumboVector* children = &node->v.element.children;
    for (unsigned int i = 0; i < children->length; ++i) {
        search_for_title(children->data[i]);
    }
}

int main() {
    const char* html = "<html><head><title>Test HTML</title></head><body><p>Hello World</p></body></html>";

    GumboOutput* output = gumbo_parse(html);

    if (output == NULL) {
        printf("HTML parsing failed\n");
        return 1;
    }

    printf("HTML parsing successful\n");
    search_for_title(output->root);

    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return 0;
}
