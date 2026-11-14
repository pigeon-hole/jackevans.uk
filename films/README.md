# Films (Culture → film projector)

The projector's reel shows the films in `films.json` (in the site's top folder), one frame of film each,
in the same order as the list. Until the list has anything in it, the reel shows numbered placeholder frames.

## Adding a film

1. Copy the `_template` entry in `films.json` into the `films` list and fill it in.
   - `id` is the film's folder name in here: lowercase, words joined with hyphens (e.g. `paris-texas`).
2. Make a folder here named after the `id`, containing:
   - `still.webp` — one shot from the film, landscape (wide shots suit the frame best; it's cropped to about 16:9).

A film whose still isn't added yet shows as an empty frame.
