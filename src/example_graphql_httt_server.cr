require "http/server"
require "json"

require "./example_graphql/query_type"

require "graphql-crystal"

module ExampleGraphqlHttpServer
  schema = GraphQL::Schema.from_schema(
    %{
      schema {
        query: QueryType,
      }

      type QueryType {
        hello: String!
      }      
    }
  )

  schema.query_resolver = QueryType

  server = HTTP::Server.new(8080) do |context|
    context.response.content_type = "application/json"
    if context.request.method == "POST"
      if body = context.request.body
        params = JSON.parse(body).raw.as(Hash(String, JSON::Type))
        context.response.print schema.execute(params).to_json
      end
    end
  end

  puts "Listening on http://0.0.0.0:8080"
  server.listen
end
