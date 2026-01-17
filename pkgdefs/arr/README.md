# *ARR Stack

## Links

- [Awesome *ARR](https://github.com/Ravencentric/awesome-arr)

## Alternatives

- [PlayTorrio](https://playtorrio.pages.dev/)

## Reddit Thread Summary: [Current Best Practices for *arr Stack](https://www.reddit.com/r/selfhosted/comments/1os6866/current_best_practices_for_arr_stack/)

### Core Stack Consensus

#### Essential Components

- **Radarr** (movies) and **Sonarr** (TV shows) - core automation
- **Prowlarr** - unified indexer management (replaces individual indexers)
- **Bazarr** - automated subtitle downloads
- **Overseerr/Jellyseerr** - user-friendly request interface
- **qBittorrent** or **Transmission** (torrents) + **SABnzbd** (Usenet)

#### Quality Profile Management

- **Profilarr** - emerging as preferred alternative to TRaSH Guides
  - Users report 40% disk space savings
  - Good out-of-box profiles without customization
  - Custom database available: [Dumpstarr on GitHub](https://github.com/Dumpstarr)
- **Recyclarr** - still used, pairs with TRaSH Guides
- **Configarr** - another alternative mentioned

### Key Architecture Decisions

#### Single vs Dual Instances (Radarr/Sonarr)

**Why run dual instances:**

- *arr apps cannot manage two copies of the same media (HD + 4K)
- To have both versions available without transcoding
- Set up: separate root folders for each instance
- Media server (Plex/Jellyfin) shows both as version options

**Why single instance:**

- Saves storage space significantly
- Works if server can handle transcoding
- Simpler to manage
- Use quality profiles to prioritize preferred resolution

**For anime:**

- Consensus: separate instances NOT needed
- Use tags and separate root folders within single instance
- Exception: if using different quality definitions (TRaSH anime-specific)

#### x265 Codec Considerations

**Arguments for x265:**

- 30-40% space savings over x264
- Modern devices increasingly support it
- Good for 4K content especially

**Arguments against:**

- TRaSH Guides biased against it (considered outdated view)
- Player compatibility issues force transcoding on older devices
- Many poorly encoded x265 releases exist

**Current consensus:** Acceptable for 4K; evaluate based on your users' devices

### Advanced/Optional Tools

#### Automation & Enhancement

- **Huntarr** - hunts down missing movies/episodes
- **Maintainerr** - auto-removes stale content (e.g., not watched in 1 year)
- **Checkrr** - scans for corrupted media files
- **Cleanuparr** - cleanup automation
- **qBit Manage** - torrent ratio and management
- **Autobrr** - advanced torrent automation
- **Pulsarr** - syncs with Plex watchlists automatically

#### Transcoding Solutions

- **Tdarr** or **Unmanic** - proactive transcoding to save space
  - Convert to AV1 (35-40% space savings reported)
  - Convert to x265 for compatibility
  - Useful workflow: grab remux → transcode yourself → better quality than scene encodes

#### Media Management

- **Kometa** (formerly PMM) - overlays, collections, posters
- **Tautulli** - Plex usage statistics and monitoring
- **Wrapperr** or **Plex Rewind** - Spotify-Wrapped style year-end summaries
- **Preroll+** - automated seasonal Plex prerolls (Halloween, Christmas, etc.)

#### Subtitles

- **Bazarr** with **Whisper AI integration** - generate subtitles using AI
  - Uses distil-large-v3.5 or large-v3 models
  - 99%+ accuracy reported
  - Fallback after other providers

#### Cloudflare Bypass

- **Byparr** - recommended (FlareSolverr successor, actively maintained)
- **FlareSolverr** - older, less maintained

#### Other

- **Lidarr** - music automation (if needed)
- **Slskd** - Soulseek for music
- **Wizarr** - user invitation management

### Technical Infrastructure

#### VPN Solutions

- **Gluetun** - container VPN routing with port forwarding
- **NetBird** - mesh VPN for remote access
- Route only download clients through VPN

#### Authentication

- **LLDAP** - lightweight directory for unified auth across services

#### Remote Access

- Cloudflare Tunnels (popular choice)
- NetBird + Nginx Proxy Manager on VPS

### Storage vs Transcoding Tradeoff

**Storage-constrained approach:**

- Single instances
- Accept x265/AV1 encodes
- Use Tdarr to proactively transcode
- Let server transcode on-demand

**Transcoding-constrained approach:**

- Dual instances (HD + 4K)
- Avoid x265 if users have incompatible devices
- Prioritize direct play
- Requires more storage

### Setup Recommendations by Experience Level

#### Minimal viable stack

- Radarr, Sonarr, Prowlarr, qBittorrent, Bazarr, Overseerr

#### Intermediate (recommended)

- Above + Profilarr/Recyclarr, Huntarr, Tautulli/Kometa, Byparr

#### Advanced/Power users

- Above + Tdarr/Unmanic, Maintainerr, Checkrr, Autobrr, specialized tools

### Notable Quotes for Decision-Making

> "I saved 40% of my disk space for my movies" - switching to Profilarr
> "Radarr/Sonarr can't handle two copies of the same movie/episode. The only way to have BOTH an HD AND a 4K version is to run two instances"
> "I personally don't mind TRaSH's bias away from x265 because a lot of my Plex users have players that don't support it"
> "Transcoding is much more practical than dual instances" - with modern hardware like Intel N-series or dedicated GPU
