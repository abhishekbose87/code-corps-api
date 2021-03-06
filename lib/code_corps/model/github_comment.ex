defmodule CodeCorps.GithubComment do
  use Ecto.Schema

  alias Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "github_comments" do
    field :body, :string
    field :github_created_at, :utc_datetime
    field :github_id, :integer
    field :github_updated_at, :utc_datetime
    field :html_url, :string
    field :url, :string

    belongs_to :github_issue, CodeCorps.GithubIssue
    belongs_to :github_repo, CodeCorps.GithubRepo
    belongs_to :github_user, CodeCorps.GithubUser

    timestamps()
  end

  @doc false
  defp changeset(struct, params) do
    struct
    |> Changeset.cast(params, [:body, :github_created_at, :github_id, :github_updated_at, :html_url, :url])
    |> Changeset.validate_required([:body, :github_created_at, :github_id, :github_updated_at, :html_url, :url])
    |> Changeset.unique_constraint(:github_id)
  end

  @doc ~S"""
  Default changeset used to create a `CodeCorps.GithubComment` record.
  """
  def create_changeset(struct, params) do
    struct
    |> changeset(params)
    |> Changeset.cast(params, [:github_issue_id, :github_repo_id, :github_user_id])
    |> Changeset.assoc_constraint(:github_issue)
    |> Changeset.assoc_constraint(:github_repo)
    |> Changeset.assoc_constraint(:github_user)
  end

  @doc ~S"""
  Default changeset used to update a `CodeCorps.GithubComment` record.
  """
  def update_changeset(struct, params) do
    struct
    |> changeset(params)
    |> Changeset.cast(params, [:github_issue_id, :github_repo_id, :github_user_id])
    |> Changeset.assoc_constraint(:github_issue)
    |> Changeset.assoc_constraint(:github_repo)
    |> Changeset.assoc_constraint(:github_user)
  end
end
