build {
  sources = [ 
    "source.amazon-ebs.ubuntu-ami"
  ]

  provisioner "file" {
    source      = "./provisioners/nodejs/app/index.js"
    destination = "/tmp/index.js"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/index.js /opt/index.js"]
  }

  provisioner "shell" {
    scripts =  [
      "./provisioners/nodejs/install_nodejs.sh",
      "./provisioners/nodejs/install_npm2.sh"
    ]
  }

  provisioner "shell" {
    script =  "./provisioners/nginx/install_nginx.sh"
  }

  provisioner "file" {
    source      = "./provisioners/nginx/conf/default"
    destination = "/tmp/default"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/default /etc/nginx/sites-available/default"]
  }

  provisioner "shell" {
    script =  "./provisioners/nginx/config_nginx.sh"
  }

  post-processor "manifest" {
    output = "${var.manifest-file-name}"
  }
}
