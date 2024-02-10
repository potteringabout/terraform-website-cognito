module "website" {
    source = "bwindsor/website/aws"
    
    deployment_name = "tf-my-project"
    website_dir = "${path.root}/website_files"
    additional_files = { "config.yaml" = <<EOF
a: 1
b: 2
EOF
  }
    hosted_zone_name = "example.com"
    custom_domain = "example.com"
    alternative_custom_domains = ["www.example.com", "other.example.co.uk"]
    alternative_custom_domain_hosted_zone_lookup = {
      "other.example.co.uk": "example.co.uk"
    }
    template_file_vars = { api_url = "api.mysite.com" }
    is_spa = false
    csp_allow_default = ["api.mysite.com"]
    csp_allow_style = ["'unsafe-inline'"]
    csp_allow_img = ["data:"]
    csp_allow_font = []
    csp_allow_frame = []
    csp_allow_manifest = []
    csp_allow_connect = []
    cache_control_max_age_seconds = 86400
    mime_types = {}
    override_file_mime_types = {
        "myfile.txt": "application/json",
    }
    redirects = [{
        source = '/home',
        target = '/index.html',
        regex  = false,
    }, {
        source = '^/device/[0-9]+$',
        target = '/index.html',
        regex  = true,
    }]
    allow_omit_html_extension = false

    is_private = true
    auth_type = "COGNITO"
    
    # These settings are requred when is_private is true and auth_type is BASIC
    basic_auth_username = "username"
    basic_auth_password = "password"
  
    # This setting is required when is_private is true and auth_type is COGNITO
    auth_config_path = "authConfig.json"

    # These settings are only used when is_private is true and auth_type is COGNITO
    create_cognito_pool = true
    refresh_auth_path = "/refreshauth"
    logout_path = "/"
    parse_auth_path = "/parseauth"
    refresh_token_validity_days = 3650
    oauth_scopes = ["openid"]
    additional_redirect_urls = ["http://localhost:3000"]  // Useful for development purposes
    
    # This setting is only required when is_private is true and auth_type is COGNITO and create_cognito_pool is true
    auth_domain_prefix = "mydomain"
    
    # This block is required when is_private is true and auth_type is COGNITO create_cognito_pool is false. Otherwise it is ignored.
    cognito = {
        user_pool_arn = aws_cognito_user_pool.mypool.arn
        user_pool_id = aws_cognito_user_pool.mypool.id
        client_id = aws_cognito_user_pool_client.myclient.id
        auth_domain = "mydomain.auth.eu-west-1.amazoncognito.com"
    }
  
    # Optional
    create_data_bucket = true
    data_path = "/data"
}