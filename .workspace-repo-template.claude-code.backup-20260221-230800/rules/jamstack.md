---
paths:
  - "**/jamstack/**"
  - "**/*.astro"
  - "**/netlify.toml"
  - "**/vercel.json"
---

# Jamstack Conventions

> Conventions for Jamstack and static site development.

## Architecture Principles

- Pre-render at build time when possible
- Use CDN for static assets
- API calls to serverless functions or external services
- Content in headless CMS or markdown

## File Structure (Astro)

```
src/
├── components/      # Reusable components
├── layouts/         # Page layouts
├── pages/           # Route-based pages
├── content/         # Markdown/MDX content
├── styles/          # Global styles
└── lib/             # Utility functions
public/              # Static assets
```

## Astro Conventions

### Components

```astro
---
// Component script (runs at build time)
interface Props {
  title: string;
  description?: string;
}

const { title, description } = Astro.props;
---

<article>
  <h1>{title}</h1>
  {description && <p>{description}</p>}
</article>

<style>
  /* Scoped styles */
  article { max-width: 65ch; }
</style>
```

### Pages

```astro
---
import Layout from '../layouts/Layout.astro';
import { getCollection } from 'astro:content';

const posts = await getCollection('blog');
---

<Layout title="Blog">
  <ul>
    {posts.map(post => (
      <li><a href={`/blog/${post.slug}`}>{post.data.title}</a></li>
    ))}
  </ul>
</Layout>
```

## Content Collections

```typescript
// src/content/config.ts
import { defineCollection, z } from "astro:content";

const blog = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    date: z.date(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { blog };
```

## Deployment Configuration

### Netlify

```toml
# netlify.toml
[build]
  command = "npm run build"
  publish = "dist"

[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200
```

### Vercel

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "astro"
}
```

## Performance Optimization

- Use `<Image>` component for optimized images
- Lazy load below-the-fold content
- Minimize client-side JavaScript
- Use appropriate cache headers

## SEO

- Include meta tags in layouts
- Generate sitemap.xml
- Use semantic HTML
- Provide alt text for images

## Anti-Patterns

- ❌ Heavy client-side rendering for static content
- ❌ Fetching data on every request that could be pre-rendered
- ❌ Large unoptimized images
- ❌ Ignoring build-time errors
- ❌ Hardcoding URLs (use environment variables)
