#!/bin/bash

# Set the repository URL
REPO_URL="https://github.com/jakubsob/shiny-acceptance-tdd"

# Create README.md if it doesn't exist
if [ ! -f README.md ]; then
    echo "# Acceptance TDD Shiny Development" > README.md
    echo "" >> README.md
    echo "<!-- START_COMMITS -->" >> README.md
    echo "<!-- END_COMMITS -->" >> README.md
fi

# Check if markers exist, add them if they don't
if ! grep -q "<!-- START_COMMITS -->" README.md; then
    echo "" >> README.md
    echo "<!-- START_COMMITS -->" >> README.md
    echo "<!-- END_COMMITS -->" >> README.md
fi

# Generate commit list to temporary file with numbers
git log --reverse --format="format:%H%n%s%n%b" |
  awk -v repo="$REPO_URL" '
    BEGIN { count = 1; RS = ""; FS = "\n" }
    $2 !~ /^chore:/ {
      hash = $1
      title = $2
      description = ""
      for(i=3; i<=NF; i++) {
        if ($i != "") {
          if ($i ~ /^-/) {  # If line starts with dash (list item)
            if (description == "") {
              description = $i
            } else {
              description = description "\n" $i
            }
          } else {  # Regular line
            if (description == "") {
              description = $i
            } else {
              description = description " " $i
            }
          }
        }
      }
      commit_url = repo "/commit/" hash
      if (description != "") {
        printf "### %d. **[%s](%s)**\n%s\n\n", count++, title, commit_url, description
      } else {
        printf "### %d. **[%s](%s)**\n\n", count++, title, commit_url
      }
    }
  ' > temp_commits.txt

# Replace content between markers
awk '
    /<!-- START_COMMITS -->/ {
        print
        system("cat temp_commits.txt")
        print ""
        found=1
        next
    }
    /<!-- END_COMMITS -->/ {
        found=0
    }
    !found {
        print
    }
' README.md > README.tmp && mv README.tmp README.md

# Clean up
rm temp_commits.txt
