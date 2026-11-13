# TV shows (Culture → TV)

The TV's pages come from `shows.json` (in the site's top folder) plus the pictures in here.

## Adding a show

1. Copy the `_template` entry in `shows.json` into the `shows` list and fill it in.
   - `id` is the show's folder name in here: lowercase, words joined with hyphens (e.g. `the-thick-of-it`).
   - `cast` is the three names, in the same order as the photos.
   - `network` is the network's logo file name (without `.webp`), and must also be listed under `networks`.
2. Make a folder here named after the `id`, containing:
   - `still.webp` — a screenshot from the series (16:9 works best), top-left
   - `poster.webp` — the show's poster (portrait, about 2:3), top-right
   - `cast-1.webp`, `cast-2.webp`, `cast-3.webp` — the cast photos (portrait, roughly 4:5), left to right
   - `logo.webp` (optional) — the show's own title logo, ideally on a transparent background. It's shown
     centred between the screenshot and the cast. Without it, the title is written out in `titleColour`.

The `description` isn't shown on the TV, but screen readers read it out.

## Adding a network

1. Put its logo in `_networks/`, named like `bbc-four.webp` (a transparent background looks best).
2. Add it to `networks` in `shows.json`: its full name, and a colour used to write the name if the logo is missing.

Anything not added yet shows as a grey box (or the network's name in type), so a show can go in before its pictures do.
