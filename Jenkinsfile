properties([
    parameters ([
        string(name: 'BUILD_NODE', defaultValue: 'omar-build', description: 'The build node to run on'),
        string(name: 'REGISTRY_URL', defaultValue: 'quay.io/radiantsolutions', description: 'REGISTRY_URL to push to'),
        booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/ossim-alpine-minimal.git'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])

node("${BUILD_NODE}"){

    stage("Checkout branch $BRANCH_NAME")
    {
        checkout(scm)
    }

    stage("Load Variables")
    {
        withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
            step ([$class: "CopyArtifact",
                projectName: o2ArtifactProject,
                filter: "common-variables.groovy",
                flatten: true])
        }

        load "common-variables.groovy"
    }

    stage ("Build Dev Image") {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                           credentialsId: 'dockerCredentials',
                           usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                           passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])               
        {                          
            if(DOCKER_REGISTRY_USERNAME&&DOCKER_REGISTRY_PASSWORD)
            {
                sh "docker login -u ${DOCKER_REGISTRY_USERNAME} -p ${DOCKER_REGISTRY_PASSWORD} ${REGISTRY_URL}"
            }            
            dir("${env.WORKSPACE}/dev"){
                sh "./build-docker.sh"
            }
        } 
    }

    stage ("Build CPP")
    {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                           credentialsId: 'dockerCredentials',
                           usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                           passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])               
        {                          
            if(DOCKER_REGISTRY_USERNAME&&DOCKER_REGISTRY_PASSWORD)
            {
                sh "docker login -u ${DOCKER_REGISTRY_USERNAME} -p ${DOCKER_REGISTRY_PASSWORD} ${REGISTRY_URL}"
            }            
            dir("${env.WORKSPACE}/dev"){
                sh "${env.WORKSPACE}/dev/run-docker.sh /scripts/build-cpp.sh"
            }
        }
    }

    stage ("Build Runtime Image")
    {
        withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
            dir("${env.WORKSPACE}/runtime"){
                sh "./build-docker.sh"
            }
        }
    }


    // stage ("Publish Docker App")
    // {
    //     withCredentials([[$class: 'UsernamePasswordMultiBinding',
    //                     credentialsId: 'dockerCredentials',
    //                     usernameVariable: 'DOCKER_REGISTRY_USERNAME',
    //                     passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])
    //     {
    //         // Run all tasks on the app. This includes pushing to OpenShift and S3.
    //         sh """
    //         ./gradlew pushDockerImage \
    //             -PossimMavenProxy=${OSSIM_MAVEN_PROXY}
    //         """
    //     }
    // }
    
    // try {
    //     stage ("OpenShift Tag Image")
    //     {
    //         withCredentials([[$class: 'UsernamePasswordMultiBinding',
    //                         credentialsId: 'openshiftCredentials',
    //                         usernameVariable: 'OPENSHIFT_USERNAME',
    //                         passwordVariable: 'OPENSHIFT_PASSWORD']])
    //         {
    //             // Run all tasks on the app. This includes pushing to OpenShift and S3.
    //             sh """
    //                 ./gradlew openshiftTagImage \
    //                     -PossimMavenProxy=${OSSIM_MAVEN_PROXY}

    //             """
    //         }
    //     }
    // } catch (e) {
    //     echo e.toString()
    // }

    stage("Clean Workspace")
    {
        if ("${CLEAN_WORKSPACE}" == "true")
            step([$class: 'WsCleanup'])
    }
}
