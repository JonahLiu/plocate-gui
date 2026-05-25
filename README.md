> **Note:** This fork has been merged upstream.  
> Active development continues at [dmnmsc/plocate-gui](https://github.com/dmnmsc/plocate-gui).  
> Please open issues and PRs there.

# Plocate GUI

A simple GUI for the `plocate` command-line utility on Linux systems. Built with PyQt6.

<div align="center">
  <img src="screenshots/plocate-gui.png" alt="plocate-gui main window"  width="70%" />
</div>

## Features

* **Fast Search:** Uses the `plocate` database.

* **Dual Database Support:** Searches system and optional external media databases concurrently.

* **Search Options:** Supports case-insensitive search (`-i`), regular expressions, and category filtering.

* **Database Update:** Executes `updatedb` via `pkexec` for system and external media indexes.

* **Item Selection (Reveal):** Highlights/selects the file in the native file manager when opening the containing folder (supports Dolphin and Nautilus).

* **Adaptive Design:** Automatic adjustment of table column widths when resizing the window.

* **Keyboard Shortcuts:**
    * **Enter** / Double-click: Opens the selected file.
    * **Ctrl+Enter** / Double-click (Path Column): Opens the containing folder.
    * **Ctrl+Shift+T**: Open the containing folder in the **Terminal**.
    * **Ctrl+Shift+D**: Select database (System, Media or both)
    * **Ctrl+F**: Move focus to the Search input field.
    * **Ctrl+G**: Move focus to the Filter input field.
    * **Ctrl+Tab**: Cycle focus between the Search and Filter input fields.
    * **Ctrl+Shift+C**: Toggle Case Sensitivity.
    * **Ctrl+Shift+L**: Toggle Live Filtering (auto-filter).
    * **Ctrl+Shift+F**: Open the Category Filter dropdown menu.
    * **Ctrl+Shift+M**: Open the Filter menu.
    * **Ctrl+Shift++**: Enable include mode in Filter menu
    * **Ctrl+Shift+-**: Enable exclude mode in filter menu.
    * **F5**: Execute the database update process (`updatedb`).
    * **F1**: Open the application's documentation/help.
    * **Esc**: Cancel current search/update task, clears results, or closes the application.

---
## Requirements

* Python 3.x
* The `plocate` package.
* PyQt6 libraries.

---
## Database Usage

The application is configured to work with the following default databases:

* **System:** `/var/lib/plocate/plocate.db` (updated with `pkexec updatedb`).

* **External Media:** `/var/lib/plocate/media.db` (created/updated with `pkexec updatedb -o ... -U /run/media`).

**Important Note:** Database updates (`Update Database`) require `pkexec` (provided by the **polkit** package) to be installed and configured to request root permissions, as the `updatedb` command needs privileges.
