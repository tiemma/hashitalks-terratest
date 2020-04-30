package tests

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/docker"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
)

const (
	HOST string = "localhost"
)

func TestDockerArtifacts(t *testing.T) {

	PORT := random.Random(5000, 8081)
	RESP := random.UniqueId()

	tag := "ecs-app"

	modulePath := "../modules/docker"

	stopOptions := &docker.StopOptions{
		Time: 15,
	}
	defer docker.Stop(t, []string{tag}, stopOptions)

	buildOptions := &docker.BuildOptions{
		Tags:      []string{tag},
		BuildArgs: []string{"--compress", "--force-rm", "--no-cache"},
	}
	docker.Build(t, modulePath, buildOptions)

	runOptions := &docker.RunOptions{
		Name:         tag,
		Detach:       true,
		Remove:       true,
		OtherOptions: []string{"--cap-add=CAP_NET_RAW", "--cap-drop=ALL", fmt.Sprintf("-p=%d:%d", PORT, PORT), fmt.Sprintf("--env=PORT=%d", PORT), fmt.Sprintf("--env=RESP=%s", RESP)},
	}
	docker.Run(t, tag, runOptions)

	url := fmt.Sprintf("http://%s:%d", HOST, PORT)
	http_helper.HttpGetWithValidation(t, url, nil, 200, RESP)
}
