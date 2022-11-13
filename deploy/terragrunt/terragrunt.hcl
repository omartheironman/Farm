remote_state{
    backend = "gcs"
    disable_init = tobool(get_env("TG_DISABLE_INIT","false"))

    config = {
        bucket   = "farm-terraform-tg"
        prefix   = "us-central1/${path_relative_to_include()}"
        project  = "farm-project"
        location = "us"
    }
}


terraform {
    extra_arguments "common_var"{
        commands = get_terraform_commands_that_need_vars()

        # optional_var_files = [
        #     "${get_terragrunt_dir()}/default.tfvars"
        # ]
    }
}