#!/bin/bash

OUTPUT_DIR="dist"
GOOGLE_PREFIX="google.*##.g:has(a[href*=\""
GOOGLE_SUFFIX="\"])"
DDG_PREFIX="duckduckgo.*##.results > div:has(a[href*=\""
DDG_SUFFIX="\"])"

# block site
awk '
{ wildcarded_url="*://"$0"/*" }
{ print wildcarded_url }
' data > "$OUTPUT_DIR/block_sites.txt"

# hide from google search results
awk -v google_prefix="$GOOGLE_PREFIX" \
    -v google_suffix="$GOOGLE_SUFFIX" \
'
{ print google_prefix $0  google_suffix }
' data > "$OUTPUT_DIR/hide_google.txt"


# hide from ddg
awk -v ddg_prefix="$DDG_PREFIX" \
    -v ddg_suffix="$DDG_SUFFIX" \
'
{ print ddg_prefix $0 ddg_suffix }
' data > "$OUTPUT_DIR/hide_ddg.txt"


# all
awk -v google_prefix="$GOOGLE_PREFIX" \
    -v google_suffix="$GOOGLE_SUFFIX" \
    -v ddg_prefix="$DDG_PREFIX" \
    -v ddg_suffix="$DDG_SUFFIX" \
'
{ wildcarded_url="*://"$0"/*" }
{ print wildcarded_url }
{ print google_prefix $0  google_suffix }
{ print ddg_prefix $0 ddg_suffix }
' data > "$OUTPUT_DIR/all.txt"
