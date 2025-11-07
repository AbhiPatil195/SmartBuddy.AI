import os
from typing import Optional

from tenacity import retry, stop_after_attempt, wait_exponential


def _get_client():
    """Lazily import OpenAI client to avoid import errors if not installed."""
    from openai import OpenAI  # type: ignore
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise RuntimeError("OPENAI_API_KEY is not set.")
    return OpenAI(api_key=api_key)


@retry(wait=wait_exponential(multiplier=1, min=1, max=8), stop=stop_after_attempt(3))
def chat_complete(system: str, user: str, model: Optional[str] = None, temperature: float = 0.8, max_tokens: int = 700) -> str:
    """Call OpenAI Chat Completions with safe defaults and retries."""
    client = _get_client()
    chosen_model = model or os.getenv("OPENAI_MODEL", "gpt-4o-mini")
    resp = client.chat.completions.create(
        model=chosen_model,
        messages=[
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
        temperature=temperature,
        max_tokens=max_tokens,
    )
    return resp.choices[0].message.content.strip()

