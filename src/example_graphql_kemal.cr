require "json"

require "./example_graphql/query_type"

require "kemal"
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

  post "/" do |env|
    env.response.content_type = "application/json"
    p env.params.json
    schema.execute(env.params.json).to_json
  end

  Kemal.run(8080)
end
