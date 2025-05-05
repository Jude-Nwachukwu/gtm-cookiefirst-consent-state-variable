___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "CookieFirst Consent State",
  "description": "Use with the CookieFirst CMP to identify the individual website user\u0027s consent state and configure when tags should execute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "cookieFirstConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "cookieFirstAllConsentState",
        "displayValue": "All Consent State Check"
      },
      {
        "value": "cookieFirstSpecificConsentState",
        "displayValue": "Specific Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific consent category or all consent categories, based on CookieFirst."
  },
  {
    "type": "RADIO",
    "name": "cookieFirstConsentCategoryCheck",
    "displayName": "Select Consent Category",
    "radioItems": [
      {
        "value": "cookieFirstPerformance",
        "displayValue": "Performance"
      },
      {
        "value": "cookieFirstNecessary",
        "displayValue": "Necessary"
      },
      {
        "value": "cookieFirstAdvertising",
        "displayValue": "Advertising"
      },
      {
        "value": "cookieFirstFunctional",
        "displayValue": "Functional"
      }
    ],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "cookieFirstConsentStateCheckType",
        "paramValue": "cookieFirstSpecificConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "cookieFirstEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "cookieFirstOptionalConfig",
    "displayName": "CookieFirst Consent State Value Transformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "cookieFirstTrue",
        "displayName": "Transform \"True\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "cookieFirstTrueGranted",
            "displayValue": "granted"
          },
          {
            "value": "cookieFirstTrueAccept",
            "displayValue": "accept"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "cookieFirstFalse",
        "displayName": "Transform \"False\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "cookieFirstFalseDenied",
            "displayValue": "denied"
          },
          {
            "value": "cookieFirstFalseDeny",
            "displayValue": "deny"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "cookieFirstUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "cookieFirstEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromWindow = require('copyFromWindow');
const getType = require('getType');
const makeString = require('makeString');

const checkType = data.cookieFirstConsentStateCheckType;
const categoryKey = data.cookieFirstConsentCategoryCheck;
const enableTransform = data.cookieFirstEnableOptionalConfig;
const transformTrue = data.cookieFirstTrue;
const transformFalse = data.cookieFirstFalse;
const transformUndefined = data.cookieFirstUndefined;

// Helper: Normalize category string
function getCategoryKey(rawKey) {
  return makeString(rawKey).replace('cookieFirst', '').toLowerCase();
}

// Helper: Get consent object from CookieFirst
function getConsentData() {
  return copyFromWindow('CookieFirst.consent');
}

// Helper: Apply output transformation
function transformValue(val) {
  if (!enableTransform) return val;

  if (val === true) {
    return transformTrue === 'cookieFirstTrueGranted' ? 'granted' : 'accept';
  }

  if (val === false) {
    return transformFalse === 'cookieFirstFalseDenied' ? 'denied' : 'deny';
  }

  if (getType(val) === 'undefined' && transformUndefined) {
    return 'denied';
  }

  return val;
}

// Main logic
const consentData = getConsentData();
const dataType = getType(consentData);

if (dataType === 'undefined') return undefined;

if (checkType === 'cookieFirstAllConsentState') {
  const result = {};
  const categories = ['performance', 'functional', 'advertising'];

  result.necessary = transformValue(true);

  if (dataType === 'null') {
    categories.forEach(function (key) {
      result[key] = transformValue(false);
    });
    return result;
  }

  if (dataType !== 'object') return undefined;

  categories.forEach(function (key) {
    const value = getType(consentData[key]) !== 'undefined' ? consentData[key] : undefined;
    result[key] = transformValue(value);
  });

  return result;

} else if (checkType === 'cookieFirstSpecificConsentState') {
  const category = getCategoryKey(categoryKey);

  if (category === 'necessary') {
    return transformValue(true);
  }

  if (dataType === 'null') {
    return transformValue(false);
  }

  if (dataType !== 'object') return undefined;

  const value = getType(consentData[category]) !== 'undefined' ? consentData[category] : undefined;
  return transformValue(value);
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "CookieFirst.consent"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/5/2025, 9:17:22 AM


