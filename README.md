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

lib/
│
├── app/
│   ├── controllers/
│   │   └── order_controller.dart
│   ├── models/
│   │   └── order_item.dart
|   |   └── product_item.dart
│   └── pages/
│       └── order_entry_page.dart
|       └── order_preview.page.dart



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

### 🔍 Product Suggestions from API (Snippet)

TypeAheadField<String>(
  suggestionsCallback: fetchSuggestions,
  itemBuilder: (context, suggestion) =>
    ListTile(title: Text(suggestion)),
  onSelected: (suggestion) {
    controller.updateProductName(index, suggestion);
  },
);

### ✅ Valid Item Check and Form Reset (Snippet)

bool get hasValidItem =>
  items.any((item) => item.productName?.isNotEmpty == true && item.quantity?.isNotEmpty == true);

void resetForm() {
  items.clear();
  addNewItem(); // Ensures one editable row
}

## 📸 Screenshots

### 📝 Order Entry Screens (IOS)

<h3 align="center">📱 App UI Screenshots</h3>

<p align="center">
  <img src="https://github.com/user-attachments/assets/98396d7b-5712-4339-b72d-aede94bb7da7" width="200" />
  <img src="https://github.com/user-attachments/assets/ee63c993-bac9-4877-8313-d05c70c1058e" width="200" />
  <img src="https://github.com/user-attachments/assets/aea1da4d-35f7-4fa5-8b10-479c041a6c57" width="200" />
  <img src="https://github.com/user-attachments/assets/df5a8900-badf-4de5-9621-23da3ea8b794" width="200" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/2ec6e964-d5cc-4d81-af88-89c172d57433" width="200" />
  <img src="https://github.com/user-attachments/assets/3cd574de-0b43-47b3-bdff-5e77d269f9df" width="200" />
  <img src="https://github.com/user-attachments/assets/d51e2de6-01b8-4acc-8546-8bc5a15a1919" width="200" />
  <img src="https://github.com/user-attachments/assets/9081c1a0-68b0-4091-91c3-43fbfa733504" width="200" />
</p>


