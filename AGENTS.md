# Project Guidelines

## Code Style
- Single Python file (`plocate-gui.py`); all classes live in one module.
- Section dividers use `# --- SECTION ---` style comments.
- Change annotations use `# NEW:`, `# FIX:`, `# MODIFICATION:`, `# CRITICAL:` prefixes.
- All user-visible strings wrapped in `_()` (gettext). Never add hardcoded English strings.
- System theme icons only: `QIcon.fromTheme("icon-name")`. Never bundle icon files.

## Architecture
- PyQt6 desktop GUI: `PlocateGUI(QWidget)` is the single main window.
- Non-blocking operations use `QRunnable` + `QThreadPool` with dedicated `*Signals(QObject)` classes.
- Key workers: `SearchWorker` (calls `plocate` CLI), `StatWorker` (calls `os.stat`), `UpdateDBWorker` (calls `pkexec updatedb`), `FilterRunnable` (in-memory regex filtering).
- Data model: `PlocateResultsModel(QAbstractTableModel)` stores tuples of `(name, path, is_dir)`.
- Dialogs: `UpdateDatabaseDialog`, `KeyboardShortcutsDialog`.

## Build and Test
- No build system. Run directly: `python3 plocate-gui.py`
- Runtime dependencies: PyQt6, `plocate` package, `pkexec` (polkit).
- `plocate` databases: `/var/lib/plocate/plocate.db` (system), `/var/lib/plocate/media.db` (external media).

## Conventions
- Category filtering: extension lists in module-level constants (e.g., `VIDEO_EXTENSIONS`) mapped in `FILE_CATEGORIES` dict, compiled to regex by `get_category_regex()`.
- Search shortcut token `::category` (e.g., `::doc`) parsed in `tokenize_search_query()` before passing to `plocate`.
- Keyboard shortcuts handled in `keyPressEvent` and `QShortcut`; also documented in `KeyboardShortcutsDialog` and README.
- Always release worker references (`self.search_worker = None`, `self.update_worker = None`) in completion callbacks.
- Database selection stored in `self._current_db_selection` ("both", `DEFAULT_DB_PATH`, or `MEDIA_DB_PATH`).
