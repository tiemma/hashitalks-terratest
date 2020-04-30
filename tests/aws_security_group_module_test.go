package tests

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAWSSecurityGroupModule(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/aws/security_group",
		Vars:         map[string]interface{}{"used_by": []string{}},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	output := terraform.OutputAll(t, terraformOptions)

	assert.Equal(t, []interface{}{}, output["ingress"])
	assert.Equal(t, []interface{}{}, output["egress"])
	assert.True(t, strings.Contains(output["arn"].(string), "arn"))
}
