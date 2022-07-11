defimpl Plug.Exception, for: Pollpal.Exceptions.Forbidden do
  def status(_), do: 403
end
