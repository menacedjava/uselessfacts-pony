use "collections"
use "net/http"
use "json"

actor Main
  new create(env: Env) =>
    HTTPClient(env.root as AmbientAuth).get("https://uselessfacts.jsph.pl/random.json?language=en", FactHandler)

class FactHandler is HTTPHandler
  fun ref apply(response: HTTPResponse ref) =>
    try
      let json = JsonDoc.parse(String.from_array(response.body))?.data as JsonObject
      let fact = json.data("text") as JsonString
      @printf[I32]("Fakt: %s\n".cstring(), fact.string().cstring())
    else
      @printf[I32]("Xatolik\n".cstring())
    end
