# Omakub (Kali Linux edition)

Turn a fresh **Kali Linux 2025.1+ GNOME** installation into a fully-configured, beautiful, and modern web development system by running a single command. This is a Kali-only fork of the upstream Ubuntu Omakub project. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the upstream introduction video and read more at [omakub.org](https://omakub.org).

## Install

### From a local checkout (recommended for this fork)

```bash
bash ~/Desktop/omakub/setup-local.sh
```

`setup-local.sh` symlinks the checkout into `~/.local/share/omakub` (where every installer expects to live) and then runs the full install. Works regardless of which directory you cloned to.

### From a remote clone (after you push your fork)

```bash
OMAKUB_REPO=https://github.com/<you>/omakub.git bash -c "$(curl -fsSL https://raw.githubusercontent.com/<you>/omakub/master/boot.sh)"
```

## What's different from upstream

| Upstream (Ubuntu)              | This fork (Kali)                                  |
|--------------------------------|---------------------------------------------------|
| `ID=ubuntu`, `VERSION_ID>=24.04` gate | `ID=kali` (rolling, 2025.1+ recommended)   |
| Docker repo `linux/ubuntu`     | Docker repo `linux/debian` pinned to `bookworm`   |
| fastfetch via PPA              | fastfetch from Kali rolling repo                  |
| ulauncher via PPA              | ulauncher from apt with GitHub `.deb` fallback    |
| Disables `*@ubuntu.com` GNOME extensions | Disables `pop-shell` + `ding` (Kali defaults) |
| Optional: Mainline Kernels (PPA) | Removed (Kali is a rolling distro)              |
| Optional editor: RubyMine (snap) | Removed (no snap on Kali)                       |

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
