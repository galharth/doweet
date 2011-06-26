Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'V1kjdreh6Peanu2zySPCw', 'rWzTNH9csrikJWlHc0BmafcDjXysVAlDxtQXbGxxBU'
  provider :facebook, '208674805836424', 'e48bdaf45dd668445788d9bd698a1b41', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
