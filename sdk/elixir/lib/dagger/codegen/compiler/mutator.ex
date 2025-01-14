defmodule Dagger.Codegen.Compiler.Mutator do
  @moduledoc false

  # Mutate graphql introspection type to make it easier to
  # compile.

  alias Dagger.Codegen.Elixir.Module, as: Mod

  @doc false
  def mutate(type) do
    type
    |> make_private()
    |> gen_module_name()
  end

  #
  # Query helper functions
  #

  defp make_private(type) do
    Map.put(type, "private", %{})
  end

  defp put_private(%{"private" => private} = type, key, value) do
    %{type | "private" => Map.put(private, key, value)}
  end

  #
  # Mutators
  #

  # Attach module name into private.
  defp gen_module_name(%{"name" => name} = type) do
    type
    |> put_private(:mod_name, Module.concat([Dagger, Mod.format_name(name)]))
  end
end
