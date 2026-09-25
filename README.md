# Michael Paciullo's website

Personal site at **https://map9959.github.io**, built with Jekyll and the
[al-folio](https://github.com/alshedivat/al-folio) v1.2 starter configuration.
The theme's layouts, styles, and features come from the Ruby gems pinned in
`Gemfile`; `Gemfile.lock` records the complete dependency versions.

## Edit the site

| Content                                       | Location                                                                |
| --------------------------------------------- | ----------------------------------------------------------------------- |
| Biography and homepage                        | `_pages/about.md`                                                       |
| Other pages and navigation                    | `_pages/`                                                               |
| Site title, URL, layout, and feature settings | `_config.yml`                                                           |
| Social links and email                        | `_data/socials.yml`                                                     |
| CV                                            | `assets/json/resume.json` (`_pages/cv.md` uses `cv_format: jsonresume`) |
| Publications                                  | `_bibliography/papers.bib`                                              |
| Projects                                      | `_projects/`                                                            |
| News                                          | `_news/`                                                                |
| Blog posts                                    | `_posts/YYYY-MM-DD-title.md`                                            |
| Images and PDFs                               | `assets/img/` and `assets/pdf/`                                         |

To feature a paper under **Selected Publications**, add `selected = {true},`
to its BibTeX entry. Publication PDFs live in `assets/pdf/`, and preview images
live in `assets/img/publication_preview/`.

This is a personal GitHub Pages site, so `_config.yml` must retain:

```yaml
url: https://map9959.github.io
baseurl:
```

## Preview locally with Docker

Install Docker with the Compose plugin, then run from this directory:

```bash
docker compose up --build
```

Visit **http://localhost:8080**. Content changes rebuild automatically.
After editing `_config.yml`, restart the server with `docker compose restart jekyll`.
After changing gem dependencies or the Dockerfile, run `docker compose up --build` again.

Press **Ctrl+C** to stop a foreground preview, then run:

```bash
docker compose down
```

For a background preview, use `docker compose up --build -d`; `docker compose down`
stops it. Generated HTML stays inside the container at `/tmp/_site`.
The optional VS Code dev container uses the same Compose service.

Docker and GitHub Actions both use Ruby **3.3.5**. If using a native Ruby setup,
install the locked Bundler version, ImageMagick, Node.js, and the Python requirements,
then run `bundle install` and `bundle exec jekyll serve` (normally port 4000).

## Check changes

Formatting uses Node.js 20 and the dependencies in `package-lock.json`:

```bash
npm ci
npm run lint:prettier
# Fix formatting when needed:
npm run format
```

Build the actual site in production mode:

```bash
docker compose run --rm -e JEKYLL_ENV=production jekyll \
  bundle exec jekyll build --destination /tmp/_site
```

Preview the homepage, CV, publications, projects, and blog after theme changes.
The repository has no tests that depend on upstream's example posts.

## Publish

Commit your changes and push to `main`. Two GitHub Actions workflows run:

- **Check formatting:** installs the locked npm dependencies and runs Prettier.
- **Deploy site:** installs the locked Ruby dependencies and builds the site.
  Pull requests build without publishing; successful builds on `main` publish
  to the `gh-pages` branch.

In **Settings → Pages**, select **Deploy from a branch**, branch **gh-pages**,
folder **/ (root)**. The deploy job requires permission to write repository contents.

## Update al-folio

Starter releases and gem versions have independent numbering. For example, this
v1.2-based site uses `al_folio_core` **1.0.15**; the other plugins have their own versions.

1. Create a branch: `git switch -c update-theme`.
2. Read the [starter release notes](https://github.com/alshedivat/al-folio/releases)
   and the relevant [plugin release notes](https://github.com/al-org-dev).
3. Edit the explicit version pins in `Gemfile`. `bundle update` alone cannot
   advance those pins. Apply any documented configuration migrations, keeping
   each plugin's `Gemfile` entry and `_config.yml` activation entry in sync.
4. Resolve the new dependencies using the existing local image:

   ```bash
   docker compose run --rm jekyll bundle install
   docker compose build
   ```

   Build the current image before editing the pins if this is a fresh checkout.
   The image build uses the lockfile in frozen mode, so update `Gemfile.lock` first.

5. Run the production build above and the upgrade checks:

   ```bash
   docker compose run --rm jekyll bundle exec al-folio upgrade audit
   docker compose run --rm jekyll bundle exec al-folio upgrade overrides audit
   ```

6. Preview, then commit `Gemfile`, `Gemfile.lock`, and any configuration or content
   migrations. Merge the branch into `main` and push when ready.

Use upstream as a reference for relevant starter changes rather than merging its
entire repository. Local `_includes/`, `_layouts/`, or `_sass/` overrides are supported
when needed; track intentional overrides with the upgrade CLI and commit its manifest.

For detailed feature configuration, see the
[upstream documentation](https://github.com/alshedivat/al-folio/tree/main/docs).

## Attribution

Based on [al-folio](https://github.com/alshedivat/al-folio). The upstream MIT license
is preserved in [LICENSE](LICENSE).
