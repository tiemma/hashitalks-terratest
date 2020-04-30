package tests

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/packer"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSEC2Module(t *testing.T) {
	t.Parallel()

	packerOptions := &packer.Options{
		Template: "../modules/packer/builder.json",
	}

	packerOutput := packer.BuildArtifact(t, packerOptions)

	awsRegion := "eu-west-1" // Packer AMIs are here
	image_name := "docker.io/tiemma/ecs-app:latest"
	sshPubKeyPath := "~/.ssh/terraform.pub"
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/aws/ec2",
		Vars: map[string]interface{}{
			"public_key_path": sshPubKeyPath,
			"security_groups": []string{},
			"image_name":      image_name,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer aws.DeleteAmiAndAllSnapshots(t, os.Getenv("AWS_REGION"), packerOutput)
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.OutputAll(t, terraformOptions)
	expectedResponse := "!dlorW elloH"
	assert.Equal(t, output["instance_state"], "running")
	http_helper.HttpGetWithValidation(t, fmt.Sprintf("http://%s", output["public_ip"].(string)), nil, 200, expectedResponse)
}
