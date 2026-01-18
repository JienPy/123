import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Package, ShoppingCart, DollarSign, ClipboardList, Clock, Truck, CheckCircle, Search } from "lucide-react";
import { Input } from "@/components/ui/input";
import { useState, useMemo } from "react";
import { useData } from "@/contexts/DataContext";
import { useNavigate } from "react-router-dom";
import { getStatusInfo } from "@/services/orders";

export default function Dashboard() {
  const { inventory, orders, orderStats, categories } = useData();
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");

  // Inventory stats
  const totalInventory = inventory.reduce((sum, item) => sum + item.quantity, 0);

  // Get low stock items (quantity < 15)
  const lowStock = inventory.filter(item => item.quantity < 15);

  // Get recent orders (latest 5)
  const recentOrders = orders.slice(0, 5);

  // Get pending orders count
  const pendingOrders = orders.filter(o => o.status === 'pending').length;

  // Filter orders for search
  const filteredOrders = useMemo(() => {
    if (!searchQuery) return recentOrders;
    const query = searchQuery.toLowerCase();
    return recentOrders.filter(order =>
      order.customer_name.toLowerCase().includes(query) ||
      order.id.toString().includes(query)
    );
  }, [searchQuery, recentOrders]);

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const stats = [
    {
      title: "Pending Orders",
      value: orderStats?.pendingToday?.toString() || "0",
      description: "new today",
      icon: Clock,
      gradient: "gradient-accent",
      onClick: () => navigate("/orders"),
    },
    {
      title: "In Progress",
      value: orderStats?.inProgress?.toString() || "0",
      description: "processing & delivery",
      icon: Truck,
      gradient: "gradient-primary",
      onClick: () => navigate("/orders"),
    },
    {
      title: "Completed Orders",
      value: orderStats?.completed?.toString() || "0",
      description: "total fulfilled",
      icon: CheckCircle,
      gradient: "gradient-accent",
      onClick: () => navigate("/sales"),
    },
    {
      title: "Total Revenue",
      value: `₱${(orderStats?.totalRevenue || 0).toLocaleString()}`,
      description: "from completed orders",
      icon: DollarSign,
      gradient: "gradient-primary",
      onClick: () => navigate("/sales"),
    },
  ];

  const inventoryStats = [
    {
      title: "Total Inventory",
      value: totalInventory.toLocaleString(),
      description: "items in stock",
      icon: Package,
      gradient: "gradient-primary",
      onClick: () => navigate("/inventory"),
    },
    {
      title: "Categories",
      value: categories.filter(c => c.status === 'active').length.toString(),
      description: "active categories",
      icon: ClipboardList,
      gradient: "gradient-accent",
      onClick: () => navigate("/settings/categories"),
    },
  ];

  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-400 bg-clip-text text-transparent">
          Dashboard
        </h1>
        <p className="text-muted-foreground mt-2">
          Welcome back! Here's your business overview.
        </p>
      </div>

      {/* Order Stats Grid */}
      <div>
        <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
          <ShoppingCart className="h-5 w-5" />
          Order Statistics
        </h2>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
          {stats.map((stat) => (
            <Card
              key={stat.title}
              className="shadow-card hover:shadow-hover transition-all duration-300 cursor-pointer hover:scale-105"
              onClick={stat.onClick}
            >
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {stat.title}
                </CardTitle>
                <div className={cn("p-2 rounded-lg", stat.gradient)}>
                  <stat.icon className="h-4 w-4 text-white" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold">{stat.value}</div>
                <p className="text-xs text-muted-foreground mt-1">{stat.description}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>

      {/* Inventory Stats */}
      <div>
        <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
          <Package className="h-5 w-5" />
          Inventory Overview
        </h2>
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
          {inventoryStats.map((stat) => (
            <Card
              key={stat.title}
              className="shadow-card hover:shadow-hover transition-all duration-300 cursor-pointer hover:scale-105"
              onClick={stat.onClick}
            >
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {stat.title}
                </CardTitle>
                <div className={cn("p-2 rounded-lg", stat.gradient)}>
                  <stat.icon className="h-4 w-4 text-white" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold">{stat.value}</div>
                <p className="text-xs text-muted-foreground mt-1">{stat.description}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        {/* Recent Orders */}
        <Card className="shadow-card">
          <CardHeader>
            <CardTitle className="flex items-center justify-between">
              <span className="flex items-center gap-2">
                <ClipboardList className="h-5 w-5 text-primary" />
                Recent Orders
              </span>
              {pendingOrders > 0 && (
                <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800 border border-yellow-300">
                  {pendingOrders} pending
                </span>
              )}
            </CardTitle>
            <div className="relative mt-4">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="Search orders..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-10"
              />
            </div>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {filteredOrders.length > 0 ? (
                filteredOrders.map((order) => {
                  const statusInfo = getStatusInfo(order.status);
                  return (
                    <div
                      key={order.id}
                      className="flex items-center justify-between py-3 border-b last:border-0 cursor-pointer hover:bg-muted/50 rounded-lg px-2 transition-colors"
                      onClick={() => navigate("/orders")}
                    >
                      <div>
                        <p className="font-medium">{order.customer_name}</p>
                        <p className="text-sm text-muted-foreground">
                          Order #{order.id} • {order.items?.length || 0} item(s)
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="font-semibold text-primary">
                          ₱{parseFloat(order.total_amount).toLocaleString()}
                        </p>
                        <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium border ${statusInfo.bgColor} ${statusInfo.color}`}>
                          {statusInfo.label}
                        </span>
                      </div>
                    </div>
                  );
                })
              ) : (
                <p className="text-sm text-muted-foreground text-center py-4">
                  {orders.length === 0 ? "No orders yet" : "No orders found"}
                </p>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Low Stock Alert */}
        <Card className="shadow-card border-accent/20">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Package className="h-5 w-5 text-accent" />
              Low Stock Alert
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {lowStock.length > 0 ? (
                lowStock.map((item) => (
                  <div
                    key={item.id}
                    className="flex items-center justify-between py-3 border-b last:border-0 cursor-pointer hover:bg-muted/50 rounded-lg px-2 transition-colors"
                    onClick={() => navigate("/inventory")}
                  >
                    <div>
                      <p className="font-medium">{item.name}</p>
                      <p className="text-sm text-muted-foreground">Reorder soon</p>
                    </div>
                    <div className="text-right">
                      <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-accent/10 text-accent border border-accent/20">
                        {item.quantity} {item.unit}
                      </span>
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground text-center py-4">All items well stocked!</p>
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

function cn(...classes: string[]) {
  return classes.filter(Boolean).join(" ");
}
