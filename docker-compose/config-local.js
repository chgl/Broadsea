define([], function () {
  var configLocal = {};

  // clearing local storage otherwise source cache will obscure the override settings
  localStorage.clear();

  // WebAPI
  configLocal.api = {
    name: "OHDSI",
    url: "${WEBAPI_URL}",
  };

  configLocal.cohortComparisonResultsEnabled = false;
  configLocal.userAuthenticationEnabled = false;
  configLocal.plpResultsEnabled = false;

  return configLocal;
});
