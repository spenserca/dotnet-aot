using System.Net;
using System.Text.Json.Serialization;
using dotnet_aot;

var builder = WebApplication.CreateSlimBuilder(args);

builder.Services.ConfigureHttpJsonOptions(options =>
{
    // options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonSerializerContext.Default);
});

builder.Services.AddGraphQLServer()
    .AddQueryType<Query>();

var app = builder.Build();

app.MapGraphQL();
app.MapGet("/heartbeat", () => "Hello World");
app.UseRouting();

app.Run();


// [JsonSerializable(typeof(Todo[]))]
// internal partial class AppJsonSerializerContext : JsonSerializerContext
// {
//
// }
