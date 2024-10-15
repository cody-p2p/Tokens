import requests

# Set API key and Custom Search Engine ID
api_key = "YOUR_API_KEY"
cx = "YOUR_CSE_ID"

# Set search query
query = "python programming"

# Send request
url = f"https://www.googleapis.com/customsearch/v1?"
params = {
    "q": query,
    "cx": cx,
    "key": api_key,
    "alt": "json"
}
response = requests.get(url, params=params)

# Parse response
data = response.json()

# Extract relevant information
for result in data["items"]:
    print(f"Title: {result['title']}")
    print(f"URL: {result['link']}")
    print(f"Snippet: {result['snippet']}")
    print()
