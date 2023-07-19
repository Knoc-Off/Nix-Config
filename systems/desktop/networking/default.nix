{ pkgs, config, libs , ... }:
{
  imports = [
  ];
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    #permitRootLogin = "yes";
  };
  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzcqPB9VHe3vEaLRHEjtk39Y0cLIzl4MoInoMOIlHR3SmaNfaSYon64UGHydcTSoYusawKN+re+OPNHB/o04j7kW7Gfn3BDVzcwv2jADKmddC9fnhNz7YYC0S2aWMkvbXgzUmiQ3vC/g71xPYULKUBB0ZNKwV8DUjP/85Ft5I4CAfdcnss4410iVmWScLcmgZWHJgT0q0IAvdBQowMyJm5UIRINgZxOSOroEwgTFY74WNy/CKfx7/kDTte6OEgKwud99GhoA4o7up3GRXMPdFEut2af9iimIC7XyVRsTmQju1Jv1rf7KItRzAXGPYBNCz030Ak9bI1y8QwMYa1E/ZcnHXihdvAeEaJsUUPw9hmKOtNAtMnY42tRE4d+ihehZSKRhpXAUSoqdMvjCRNg2QjDvnv98GrAa7Mcbg7n5scCjuoczvaQ7cOAOGAYqLHLSBl9wqxUk9dZo0oTW/5NkHpslRNEy25biBqJukJAylLNXcB0YdnlTYDTcnyGtj9TIk= knoff"
  ];

  networking.hostName = "lapix-pc";

}
