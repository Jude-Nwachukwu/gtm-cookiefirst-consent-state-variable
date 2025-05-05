# CookieFirst Consent State – GTM Custom Variable Template (Unofficial)

This Google Tag Manager (GTM) custom variable template retrieves user consent states from the [CookieFirst Consent Management Platform (CMP)](https://cookiefirst.com/). It's especially useful when:

- CookieFirst is installed **outside GTM** (i.e., directly on your website).
- You are implementing **Basic or Advanced Consent Mode** in GTM.
- You need to create **exception triggers** based on consent for specific categories.

> Developed by **Jude Nwachukwu Onyejekwe** for [DumbData](https://dumbdata.co/)

---

## 🛠️ How to Use This Template


## 📦 Import the Template

1. Open Google Tag Manager.
2. Go to **Templates** → **Variable Templates**.
3. Click the **New** button and select **Import**.
4. Upload the `.tpl` file for this template.

## 🎛️ Configuration Options

### 1. **Select Consent State Check Type**

Use the dropdown labeled **“Select Consent State Check Type”** to choose how the variable behaves:

- **All Consent State Check** – Returns an object of all major consent categories and their current status.
- **Specific Consent State** – Returns the current status of one specific category.

### 2. **Select Consent Category**

(Only shown when **Specific Consent State** is selected)

Use the radio field **“Select Consent Category”** to choose one of the following:

- Performance  
- Necessary  
- Advertising  
- Functional  

**Note:** “Necessary” will always return `true` since it cannot be disabled in CookieFirst.

### 3. **Enable Optional Output Transformation**

Use the checkbox **“Enable Optional Output Transformation”** to convert raw Boolean values into strings for easier GTM integration.

#### Sub-options (shown when enabled):

- **Transform "True"**: Choose between:
  - `granted`
  - `accept`

- **Transform "Deny"**: Choose between:
  - `denied`
  - `deny`

- **Also transform "undefined" to "denied"**: Applies a fallback value for uninitialized states.

## ⚒️ Use Cases

- Enabling or blocking GTM tags based on consent preferences
- Using CookieFirst’s consent values with **Basic or Advanced Consent Mode**
- Creating exception triggers for marketing, functional, or performance tags

---

> ⚙️ This template ensures your GTM tags respect CookieFirst consent settings—even when the CMP is installed directly on the website.
