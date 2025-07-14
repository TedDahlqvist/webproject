# Godot Web Project Deployment Guide

## Local Testing
Your project now includes a custom `server.py` that provides the necessary headers for Godot web exports.

### Running Locally:
```bash
python server.py
```
Then open: http://localhost:8000/webexport.html

## Online Hosting Options

### 1. GitHub Pages (Free) - RECOMMENDED APPROACH
GitHub Pages has limitations with modern web features, so we need a specific approach:

**Option A: Use the included index.html (Recommended)**
1. Commit and push all files including `index.html`
2. Go to your repository settings on GitHub
3. Scroll down to "Pages" section
4. Set source to "Deploy from a branch"
5. Select "main" branch and "/ (root)" folder
6. Your game will be available at: `https://yourusername.github.io/repositoryname/`

**Option B: Re-export for GitHub Pages**
1. In Godot, use the "GitHub Pages" export preset
2. Export the project (this will create index.html with GitHub Pages compatible settings)
3. Commit and push all files
4. Follow steps 2-6 from Option A

**GitHub Pages Limitations:**
- No Cross-Origin Isolation headers (threading disabled)
- No Service Worker support
- Some modern web features may not work

**Files to commit for GitHub Pages:**
```
git add .
git commit -m "Add GitHub Pages compatible web export"
git push origin main
```

### 2. Netlify (Free tier available)
1. Drag and drop your project folder to netlify.com
2. Your game will be available immediately
3. For custom headers, add a `_headers` file:
```
/*
  Cross-Origin-Embedder-Policy: require-corp
  Cross-Origin-Opener-Policy: same-origin
  Access-Control-Allow-Origin: *
```

### 3. Vercel (Free tier available)
1. Connect your GitHub repository to Vercel
2. Add a `vercel.json` file:
```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "Cross-Origin-Embedder-Policy",
          "value": "require-corp"
        },
        {
          "key": "Cross-Origin-Opener-Policy", 
          "value": "same-origin"
        }
      ]
    }
  ]
}
```

### 4. itch.io (Game hosting platform)
1. Export as HTML5/WebGL from Godot
2. Zip all the webexport files
3. Upload to itch.io as HTML project
4. Enable "This file will be played in the browser"

## Files Needed for Web Hosting:
- `webexport.html` (main page)
- `webexport.js` (game engine)
- `webexport.wasm` (compiled game)
- `webexport.pck` (game data)
- `webexport.png` (loading screen)
- `webexport.icon.png` (favicon)
- Audio worklet files (if using audio)

## Troubleshooting Common Issues:

### Black Screen:
- Check browser console for errors
- Ensure all files are uploaded
- Verify server headers (CORS, Cross-Origin Isolation)

### Loading Errors:
- Check file paths are correct
- Ensure MIME types are set properly (.wasm, .pck files)
- Verify files aren't corrupted during upload

### Performance Issues:
- Enable threading in export settings
- Compress textures for web
- Optimize audio files
- Consider Progressive Web App features

## Current Export Settings:
- Thread support: Enabled
- Cross-origin isolation: Handled by server
- Canvas resize policy: Adaptive
- Export path: `webexport.html`
