class GraphqlController < ApplicationController
  SCHEMA = GraphQL::Api::Schema.new.schema

  def index
    render json: SCHEMA.execute(GraphQL::Introspection::INTROSPECTION_QUERY)
  end

  def create
    render json: SCHEMA.execute(
      params[:query],
      variables: params[:variables] || {},
    )
  end

end
