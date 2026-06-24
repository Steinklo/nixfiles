# Kitty Cheatsheet

## Tabs
Ctrl + Shift + T        # New tab
Ctrl + Shift + H/L      # Previous/next tab
Ctrl + Shift + Q        # Close window

## Scrollback (search on-screen output)
Ctrl + Shift + Up/Down          # Scroll one line
Ctrl + Shift + PageUp/PageDown  # Scroll one page
# Note: the default Ctrl+Shift+H (show scrollback in pager) is rebound to
# "previous tab" in our config. Use the scroll keys above, or pipe to less:
#   <command> | less   ->  press / to search, n for next match

## Command history (shell)
Ctrl + R                # Search history backwards (press again for older matches)
Up / Down arrow         # Step through one by one
history                 # Print the full history
!!                      # Re-run the previous command
!abc                    # Re-run the last command starting with "abc"

## Most used commands
history | awk '{$1=""; print}' | sort | uniq -c | sort -rn | head -20
# Top 20 most used commands (strips the leading history number first)
