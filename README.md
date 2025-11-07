# SmartBuddy.AI

A free, mobile-friendly AI web app with four tools in one simple interface:

- ChatStyle – Caption & Message Generator
- TalkSmart – Relationship & Conversation Helper
- QuickTranslate – Multi-Language Translator (EN/MR/KN/HI)
- DailyPal – Optional day planner (time-block + to-do)

Built with Streamlit for fast, mobile-first usage and easy sharing (WhatsApp/Instagram/LinkedIn bios).

## Features

- Language selector: English / Marathi (मराठी) / Kannada (ಕನ್ನಡ) / Hindi (हिन्दी)
- Consistent system prompt: responds only in selected language; friendly and concise
- WhatsApp share links and copy buttons
- No data storage; ephemeral sessions

## Local Setup (Pinned, Reproducible)

1. Install Python 3.10 (recommended) or 3.9–3.12.
2. Set your OpenAI API key:

   - Windows (PowerShell):
     ```powershell
     setx OPENAI_API_KEY "YOUR_KEY_HERE"
     ```
   - Or create a `.env` file with:
     ```
     OPENAI_API_KEY=YOUR_KEY_HERE
     ```
3. Install dependencies into a local virtualenv (exact pinned versions):

   - PowerShell (recommended, uses lock file):
     ```powershell
     cd SmartBuddy.AI
     ./install.ps1 -UseLock
     ```

   - Alternatively (uses requirements.txt, also pinned):
     ```powershell
     cd SmartBuddy.AI
     ./install.ps1
     ```

4. Run the app without activating the venv:

   ```powershell
   ./run.ps1
   ```

## Deployment (Reproducible)

- Streamlit Community Cloud: add repo, set `OPENAI_API_KEY` secret, entrypoint `app.py`. Uses `runtime.txt` to pin Python 3.10.13.
- Hugging Face Spaces: Streamlit template; add secret as env var.
- Vercel (optional via `streamlit` runtime): ensure Python and env var configured.

## Environment Variables

- `OPENAI_API_KEY` (required)
- `OPENAI_MODEL` (optional, default: `gpt-4o-mini`)

## Notes

- Copy-to-clipboard uses a lightweight JS snippet inside Streamlit.
- WhatsApp share uses `https://wa.me/?text=` links.
- This app does not store user data.
