require "graphql-crystal"

module QueryType
  include GraphQL::ObjectType
  extend self

  field :hello do
    "world"
  end
end