package tests

import (
	"os"
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/packer"

	"github.com/stretchr/testify/assert"
)

func TestPackerArtifact(t *testing.T) {
	t.Parallel()
	packerOptions := &packer.Options{
		Template: "../modules/packer/builder.json",
	}

	output := packer.BuildArtifact(t, packerOptions)

	defer aws.DeleteAmiAndAllSnapshots(t, os.Getenv("AWS_REGION"), output)

	matches := regexp.MustCompile(`ami-*`).MatchString(output)
	assert.True(t, matches)
}
