class K8sController < ApplicationController
  # REPO_ID_MAP = {
  #   46313587: 'moneyforward/ca_web'
  # }

  def index
    @namespaces = namespaces
    @namespace = params[:namespace] || namespaces.first.metadata.name
    @ingresses = ingresses

    # terms = @namespace.split('-')
    # repo_id = terms.size > 2 ? terms[-2].to_i : nil
    # @repo_name = repo_id ? REPO_ID_MAP[repo_id.to_i] : nil
  end

  private

  def namespaces
    @namespaces ||= k8s_client.api('v1').resource('namespaces').list
  end

  def ingresses
    @ingresses ||= k8s_client.api('networking.k8s.io/v1').resource('ingresses', namespace: @namespace).list
  end

  def k8s_client
    @k8s_client ||= K8s::Client.config(K8s::Config.load_file('~/.kube/config'))
  end

  def octokit_client
    # @octokit_client ||= Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end
end
