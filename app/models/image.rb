require "aws-sdk-s3"

class Image
  def initialize(mission)
    @service_client = Aws::S3::Client.new(
      region:            Rails.application.credentials.aws_region,
      access_key_id:     Rails.application.credentials.access_key_id,
      secret_access_key: Rails.application.credentials.secret_access_key
    )
    @mission = mission
  end

  def fetch_image
    return unless @mission.status == "Successful"

    response = @service_client.get_object(
      bucket: Rails.application.credentials.bucket,
      key:    @mission.image
    )

    response.body.read
  end
end
