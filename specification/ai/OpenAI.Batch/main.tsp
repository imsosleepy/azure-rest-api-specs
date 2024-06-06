import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/versioning";

import "./batch/main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;


#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI {

}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.AI.OpenAI {

}

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure OpenAI API",
})
@versioned(ServiceApiVersions)
@doc("Azure OpenAI API for batch.")
namespace Azure.AI.OpenAI.Batch {
  @doc("The known set of supported API versions.")
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    @doc("The July 2024 preview release for Azure OpenAI, including the batch API.")
    v2024_07_01_Preview: "2024-07-01-preview"
  }
}