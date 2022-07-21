## Ongoing Issues

### Flowbite + Turbo

We use the Tailwind CSS component library [Flowbite](https://flowbite.com/) for some UI elements. Flowbite's JavaScript library currently relies on the `DOMContentLoaded` event for initalization. In our [Turbo](https://turbo.hotwired.dev/) environment, this is a problem; the Flowbite behavior is only applied on initial pageload, and then disappears after the first Turbo navigation. (This is a [known issue](https://github.com/themesberg/flowbite/issues?q=is%3Aissue+is%3Aopen+domcontentloaded).)

We resolve this with the method suggested [here](https://github.com/themesberg/flowbite/issues/88): we patch Flowbite using the [patch-package](https://github.com/ds300/patch-package) package to replace `DOMContentLoaded` with `turbo:load`. This occurs as a `postinstall` Yarn script in `package.json`; every time Yarn installs Flowbite, it immediately patches it with our patchfile.

This does mean, of course, that our patchfile will have to be updated anytime Flowbite is. (As of 2022-04-27, we haven't lived this out, so the information below could change after we've experienced an update. I'm hoping patch-package recognizes the diff won't work and notifies us that the patchfile needs updating rather than a more silent and invisible failure.)

**What this means for you:** First, just be aware this is happening. Second, if you update Flowbite, be prepared to patch it as described below. Third, remain uncomfortable with this solution to ensure you still have good instincts.

#### How to update the patchfile

When we do update Flowbite, here's how to generate a new patchfile:

1. Update Flowbite
1. Open `flowbite.js` (currently at `{repo}/node_modules/flowbite/dist/flowbite.js`)
1. Change all `DOMContentLoaded` references to `turbo:load` and save
1. Run `patch-package flowbite`
    - ⚠️ This may have to be invoked as `npx patch-package flowbite`
1. Run/test the app to ensure Flowbite-provided elements still work; be sure to navigate to new pages
1. Commit the resulting patchfile in `{repo}/patches/` to the repo

#### When can we stop doing this?

Great question! We have to keep doing this until Flowbite natively initializes in a way that survives Turbo page navigation. Let's keep an eye out for that update.