CONFIG=$@

for line in $CONFIG; do
  eval "$line"
done

# Check that required variables are provided
for variable in repository archive tag; do
  if [ -z "${!variable}" ]; then
    echo "${variable} is mandatory. Please add ${variable}=value"
    exit 1
  fi
done

(    ( [ -z $user ] && [ -z $github_api_token ] ) \
  || ( [ $user ] && [ $github_api_token ] ) \
  ) && { echo "Variable user or github_api_token must be provided"; exit 1; }

[ ! -f "$archive" ] && { echo "File $archive not found"; exit 1; }

USE_TOKEN=1
if [ $user ]; then USE_TOKEN=0; fi

if [ -z $organization ]; then
  organization=$user
  echo "Warning: using organization=$user as no organization was provided"
fi
if [ -z $name ]; then name=$tag; fi

# path="test"
# version="1.0"
# tag="v1.0"

curl_opt="-s"

if [ $USE_TOKEN -eq 1 ]; then
  # Using token
  AUTH="Authorization: token $github_api_token"
  send_cmd="curl $curl_opt -H $AUTH"
else
  # Using github password
  echo -n "Password for $user on github.com: "
  if [ -z $password ]; then
    read -s password
    echo
  fi
  send_cmd="curl $curl_opt -u $user:$password"
fi

generate_post_data() {
  echo \
  { \
    '"'"tag_name"'"':'"'"$tag"'"', \
    '"'"name"'"':'"'"$name"'"', \
    '"'"body"'"':'"'"$body"'"', \
    '"'"draft"'"':false, \
    '"'"prerelease"'"':false \
  }
    # '"'"target_commitish"'"':'"'"$tag"'"',
}

GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/$organization/$repository"

# Validate access
${send_cmd} $GH_REPO > /dev/null || { echo "Error: Invalid repo, token or network issue!"; exit 1; }
echo "Authentication succeeded."

# Create tarball
# git --git-dir=$path/.git tag -l $tag > /dev/null
# [ $? -eq 0 ] || { echo "Tag $tag does not exists"; exit 1; }

# tarball="$repository-${tag}.tar.gz"
# git --git-dir=$path/.git archive --prefix="$repository-$tag/" $tag | gzip -c > $tarball
# echo "Created $tarball from tag ${tag}."

# Create release
response=$(${send_cmd} -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "$(generate_post_data)" $GH_REPO/releases)
release_id=$(echo "$response" | jq .id)
release_url=$(echo "$response" | jq .url)
assets_url=$(echo "$response" | jq .upload_url)
echo "Created release $release_id: $release_url"
upload_url=$(echo $assets_url | sed 's/{[^}]*}//')
upload_url="${upload_url%\"}" # Remove first "
upload_url="${upload_url#\"}" # Remove last "
# echo $upload_url

# Delete release
# ${send_cmd} -X DELETE "$GH_REPO/releases/$release_id"

# Add release asset
response=$( ${send_cmd} -X POST --data-binary @$archive -H "Content-Type: application/octet-stream" "$upload_url?name=$(basename $archive)" )
echo "Uploaded $archive: $(echo $response | jq .browser_download_url)"
