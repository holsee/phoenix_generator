defmodule Phoenix.Gen.Utils do

  # generate a file applying bindings and write it to disk
  # src_path is relative to phoenix_generator
  # dst_path is relative to enclosing project root
  def gen_file(src_path, dst_path, bindings \\ []) do
    src_path = Path.join([
      Mix.Project.deps_path, "phoenix_generator", "templates"] ++ src_path)
    dst_path = Path.join([File.cwd!, "web"] ++ dst_path)

    rendered_file = EEx.eval_file src_path, bindings

    Mix.Generator.create_file(dst_path, rendered_file)
  end


  @doc "adds a pading to the begining of lines in a string"
  def pad_string(str, padding) when is_binary str do
     padding <> String.replace(str, ~r/(?:(?!\n$)\n)/s, ("\n"<>padding))
  end

  @doc "returns the enclosing app's name camel case"
  def app_name_camel() do
    Mix.Utils.camelize app_name
  end

  def app_name() do
    Atom.to_string Mix.Project.config()[:app]
  end

  def models_path do
    Path.join ~w|web models|
  end

  def migrations_path do
    Path.join ~w|priv repo migrations|
  end

  def views_path do
    Path.relative_to Path.join(~w|web views|), Mix.Project.app_path
  end

  def templates_path do
    Path.relative_to Path.join(~w|web templates|), Mix.Project.app_path
  end
end
