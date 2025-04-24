# 🛒  Order Management App

A sleek and intuitive **Order Entry & Preview Application** built with **Flutter** using **GetX** for state management. Users can enter products with notes or images, preview the order summary, and confirm submission with modern UI interactions.

---

## ✨ Features

- 📋 **Dynamic Order Entry** with auto-suggestions
- 📝 Add **notes** and **images** via a bottom sheet
- 👁️ **Preview Order** before submission
- 🎨 Aesthetic **UI with teal theme**
- 🔄 Form reset with one click
- ✅ Validations for clean data input
- 📦 Clean architecture with GetX

---

## 📂 Project Structure

```text
lib/
│
├── app/
│   ├── controllers/
│   │   └── order_controller.dart
│   ├── models/
│   │   ├── order_item.dart
│   │   └── product_item.dart
│   └── pages/
│       ├── order_entry_page.dart
│       └── order_preview_page.dart
```



---

## 📦 Packages Used

| Package                  | Purpose                                      |
|--------------------------|----------------------------------------------|
| **get**                  | State management, routing, snackbar          |
| **flutter_typeahead**    | Suggestion dropdown for product input        |
| **image_picker**         | Picking images from gallery or camera        |
| **http**                 | Fetching product name suggestions (mocked)   |
| **google_fonts**                 | Using Specfied Fonts Provided by Google


## 🚀 How to Run

1. git clone https://github.com/ASUSTHENOOB/order_inventory.git
cd order_management_app
2. flutter pub get
3. flutter run


## 🧠 Core Logic Explained

---

### 🔄 Dynamic Item Management && Preview

- The app uses `GetX` and `RxList<OrderItem>` to manage real-time updates in the UI.
- Each time a user fills in the last item’s product name and quantity, a new editable item is added automatically.
- Items are displayed with their `productName`, `quantity`, and optional `note` or `image` indicators.
- Displays order number.
- Lists products, quantities, notes, images.
- Shows delivery date, total quantities, and total estimated amount.

### 🧾 Bottom Sheet for Notes and Image (Snippet)

```text
void _showNoteImageSheet(int index) {
  Get.bottomSheet(
    Container(
      child: Column(
        children: [
          TextField(),            
          ElevatedButton(),       
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
```

### 🔍 Product Suggestions from API (Snippet)

```text
TypeAheadField<String>(
  suggestionsCallback: fetchSuggestions,
  itemBuilder: (context, suggestion) =>
    ListTile(title: Text(suggestion)),
  onSelected: (suggestion) {
    controller.updateProductName(index, suggestion);
  },
);
```

### ✅ Valid Item Check and Form Reset (Snippet)

```text
bool get hasValidItem =>
  items.any((item) => item.productName?.isNotEmpty == true && item.quantity?.isNotEmpty == true);

void resetForm() {
  items.clear();
  addNewItem(); // Ensures one editable row
}

```

## 📸 Screenshots

### 📝 Order Entry Screens (IOS)

<h3 align="center">📱 ENTRY UI </h3>

<p align="center">
  <img src="https://github.com/user-attachments/assets/98396d7b-5712-4339-b72d-aede94bb7da7" width="230" />
  <img src="https://github.com/user-attachments/assets/ee63c993-bac9-4877-8313-d05c70c1058e" width="230" />
  <img src="https://github.com/user-attachments/assets/aea1da4d-35f7-4fa5-8b10-479c041a6c57" width="230" />
  <img src="https://github.com/user-attachments/assets/df5a8900-badf-4de5-9621-23da3ea8b794" width="230" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/2ec6e964-d5cc-4d81-af88-89c172d57433" width="230" />
  <img src="https://github.com/user-attachments/assets/3cd574de-0b43-47b3-bdff-5e77d269f9df" width="230" />
  <img src="https://github.com/user-attachments/assets/d51e2de6-01b8-4acc-8546-8bc5a15a1919" width="230" />
  <img src="https://github.com/user-attachments/assets/e3d8469c-265e-4034-9475-df75bf248d0a" width="230" />

</p>

### 📝 Order Preview Screens (IOS)

<h3 align="center">📱 PREVIEW UI </h3>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bfff5e3b-7e4a-459e-962b-d48b366991d8" width="230" />
  <img src="https://github.com/user-attachments/assets/3ef6f473-175c-4eb6-85c3-d0d3a53c5a80" width="230" />
</p>



### 📝 Order Entry Screens (ANDROID)
<!-- Scrollable horizontal gallery for Android screenshots -->

<h3 align="center">📱 ENTRY UI </h3>


<div style="display: flex; overflow-x: auto; gap: 10px; padding: 10px 0;">
  <img src="https://github.com/user-attachments/assets/4efa1859-817b-4e37-ac22-79ee6da49cf4" width="230" />
  <img src="https://github.com/user-attachments/assets/e8e5b4d5-fe53-4c2e-8a40-bcb9086accf8" width="230" />
  <img src="https://github.com/user-attachments/assets/86069147-a04f-4645-a6a9-29a986f2a173" width="230" />
  <img src="https://github.com/user-attachments/assets/68823b39-e244-4cc3-bf76-68e80147deb1" width="230" />
  <img src="https://github.com/user-attachments/assets/0458d65e-cc2b-408d-94db-e058b46b8c11" width="230" />
  <img src="https://github.com/user-attachments/assets/fde98296-6aa8-423e-b867-4e12153116ba" width="230" />
  <img src="https://github.com/user-attachments/assets/47496193-5fe5-4b34-b221-db848c3f35c3" width="230" />
  <img src="https://github.com/user-attachments/assets/6a1f2e46-1a27-4bb3-94e3-15079dbfc850" width="230" />
  <img src="https://github.com/user-attachments/assets/d987cdc8-8b70-428c-8c7a-a1fb58025f8a" width="230" />
  <img src="https://github.com/user-attachments/assets/6904a773-310f-4b69-815c-7b328291f242" width="230" />
  <img src="https://github.com/user-attachments/assets/e5b43700-6382-40b2-aaa4-afd86953e2aa" width="230" />
  <img src="https://github.com/user-attachments/assets/4316bff6-e8a8-4efb-8588-245830c0d80e" width="230" />
  <img src="https://github.com/user-attachments/assets/85cfae66-2690-44ca-b367-0efa84ffb7d4" width="230" />
  <img src="https://github.com/user-attachments/assets/c27a0b21-4223-402f-baaf-82bfaac2ddb8" width="230" />
  <img src="https://github.com/user-attachments/assets/b3284c16-28fc-4285-ade1-88bcf1afb82f" width="230" />
</div>


<h3 align="center">📱 PREVIEW UI </h3>
<div style="display: flex; overflow-x: auto; gap: 10px; padding: 10px 0;">
<img src="https://github.com/user-attachments/assets/85cfae66-2690-44ca-b367-0efa84ffb7d4" width="230" />
  <img src="https://github.com/user-attachments/assets/c27a0b21-4223-402f-baaf-82bfaac2ddb8" width="230" />
</div>
