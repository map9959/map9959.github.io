# Project guidance

This repository is Michael Paciullo's personal website, not the al-folio theme's
development repository. Read `README.md` for editing, preview, deployment, and updates.

- Preserve personal content in `_pages`, `_posts`, `_projects`, `_news`,
  `_bibliography`, `_data`, and `assets`.
- The site is hosted at `https://map9959.github.io`; keep `baseurl` empty.
- Theme runtime comes from the pinned gems in `Gemfile`. Keep plugin dependencies
  and the `plugins` list in `_config.yml` aligned. Commit lockfile changes when
  intentionally updating dependencies.
- Social links live in `_data/socials.yml`. The CV uses `assets/json/resume.json`.
- Local theme overrides are allowed when needed. Review them with
  `bundle exec al-folio upgrade overrides audit` and commit the override manifest.
- CI consists of a site build/deployment and a formatting check. Do not reintroduce
  upstream demo-dependent tests, release automation, or theme-maintainer tooling.
- Use the existing Docker Compose setup for local builds and previews. It uses
  Ruby 3.3.5, matching CI, and writes generated output inside the container.
- Verify meaningful changes with `npm run lint:prettier` and a production Jekyll
  build. For theme/configuration changes, also run the upgrade audit and inspect
  the affected pages. Commands are documented in `README.md`.
