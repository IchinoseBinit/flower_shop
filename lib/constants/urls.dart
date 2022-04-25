// const baseUrl = "http://10.0.2.2:8000";
const baseUrl = "http://192.168.1.244:8000";
// const baseUrl = "http://192.168.7.32:3001";

const _users = "$baseUrl/authentication";

const registerUrl = "$_users/register/";
const loginUrl = "$_users/login/";
const logoutUrl = "$_users/logout/";
const changePasswordUrl = "$_users/change-password/";
const passwordResetUrl = "$_users/password-reset/";

const _productsCategories = "$baseUrl/product-categories";

const productsUrl = "$_productsCategories/products/";
const latestProductsUrl = "${productsUrl}recently/";
const popularProductsUrl = "${productsUrl}popular/";

const categoriesUrl = "$_productsCategories/categories/";
const categoriesProductsUrl = "${categoriesUrl}products/";

// 'user-orders/<int:user_id>', UserOrdersView.as_view(), name='user-orders'),
//     path('orders-list/', OrdersView.as_view(), name="orders-list"),
//     path('order-details/<int:id>

const orderUrl = "$baseUrl/orders";
const userOrderUrl = "$orderUrl/user-orders/";
const orderListUrl = "$orderUrl/orders-list/";
const orderDetailsUrl = "$orderUrl/order-details/";
