# events.vex

TypeScript client for the [VEX Events API](https://events.vex.com/api/v2) at [events.vex.com](https://events.vex.com).

This package is the maintained fork of [`robotevents`](https://github.com/brenapp/robotevents) for the VEX / GRSF competition platform. It targets the new API host and public site URLs used by VEX events going forward.

**`7.0.0`** is the first npm release of `events.vex` (successor to robotevents v6 for [events.vex.com](https://events.vex.com)).

## Basic usage

```typescript
import { Client, programs } from "events.vex";

const client = Client({
  authorization: { token: "<AUTH TOKEN>" },
});

const result = await client.programs.get(programs.V5RC);

if (result.error) {
  console.log(result.response.statusText);
} else {
  console.log(result.data);
}

const events = await client.events.search({ "sku[]": ["RE-VRC-23-1488"] });
console.log(events.data);
```

## Migration from `robotevents`

If you currently use the [`robotevents`](https://www.npmjs.com/package/robotevents) package against `robotevents.com`, follow these steps to switch to `events.vex`.

### 1. Install the new package

```bash
npm uninstall robotevents
npm install events.vex
```

### 2. Update imports

```typescript
// before
import { Client } from "robotevents";

// after
import { Client } from "events.vex";
```

### 3. Update types (optional)

If you annotate client types explicitly, rename the exported type:

```typescript
// before
import type { RobotEventsClient } from "robotevents";

// after
import type { VexEventsClient } from "events.vex";
```

`RobotEventsClient` is still exported as a deprecated alias, but new code should use `VexEventsClient`.

### 4. Review URL and host changes

| | `robotevents` | `events.vex` |
| --- | --- | --- |
| API base URL | `https://www.robotevents.com/api/v2` | `https://events.vex.com/api/v2` |
| Event pages (`event.getURL()`) | `https://www.robotevents.com/{sku}.html` | `https://events.vex.com/{sku}.html` |
| Team pages (`team.getURL()`) | `https://www.robotevents.com/teams/...` | `https://events.vex.com/teams/...` |

You do **not** need to configure the API base URL manually — it is built into the client. If you hard-coded `robotevents.com` links elsewhere in your app, update those to `events.vex.com`.

### 5. Client setup stays the same (v6 users)

If you are already on **robotevents v6**, the `Client()` API is unchanged:

```typescript
const client = Client({
  authorization: { token: "<AUTH TOKEN>" },
});

await client.events.search({ "sku[]": ["RE-VRC-23-1488"] });
await client.teams.getByNumber("3796B", programs.V5RC);
```

Wrapper classes (`Event`, `Team`, `Match`) and endpoint helpers (`programs`, `seasons`, etc.) work the same way.

### 6. Upgrading from robotevents v5 or earlier

This fork is based on the **v6** openapi-fetch architecture. If you are on robotevents v5 or below, migrate to v6 first using the upstream [robotevents v6 release notes](https://github.com/brenapp/robotevents), then apply the package rename above.

The v5 API (`setBearer`, global request helpers, etc.) is not supported in v6 or this fork.

### Migration checklist

- [ ] Replace `robotevents` with `events.vex` in `package.json`
- [ ] Update import paths
- [ ] Replace `RobotEventsClient` with `VexEventsClient` in type annotations
- [ ] Search your codebase for hard-coded `robotevents.com` URLs
- [ ] Confirm your auth token works against [events.vex.com](https://events.vex.com)
- [ ] Run your test suite against the new API host

## Related links

- API documentation: https://events.vex.com/api/v2
- Upstream project: https://github.com/brenapp/robotevents
- This fork: https://github.com/Jerrylum/events.vex
