json.array!(@solvers) do |solver|
  json.extract! solver, :id
  json.url solver_url(solver, format: :json)
end
