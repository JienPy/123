import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Package, ShoppingCart, DollarSign, TrendingUp, Search } from "lucide-react";
import { Input } from "@/components/ui/input";
import { useState, useMemo } from "react";
import { useData } from "@/contexts/DataContext";
import { useNavigate } from "react-router-dom";

export default function Dashboard() {
  const { inventory, sales } = useData();
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  // Calculate real stats
  const totalInventory = inventory.reduce((sum, item) => sum + item.quantity, 0);
  const totalRevenue = sales.reduce((sum, sale) => sum + sale.amount, 0);
  const completedSales = sales.filter(sale => sale.status === "Completed");
  const totalSales = completedSales.reduce((sum, sale) => sum + sale.amount, 0);
  
  // Calculate growth (comparing first half vs second half of sales)
  const midPoint = Math.floor(sales.length / 2);
  const recentSalesAmount = sales.slice(0, midPoint).reduce((sum, sale) => sum + sale.amount, 0);
  const olderSalesAmount = sales.slice(midPoint).reduce((sum, sale) => sum + sale.amount, 0);
  const growth = olderSalesAmount > 0 ? Math.round(((recentSalesAmount - olderSalesAmount) / olderSalesAmount) * 100) : 0;

  const stats = [
    {
      title: "Total Inventory",
      value: totalInventory.toLocaleString(),
      description: "items in stock",
      icon: Package,
      gradient: "gradient-primary",
      onClick: () => navigate("/inventory"),
    },
    {
      title: "Total Sales",
      value: `₱${totalSales.toLocaleString()}`,
      description: "completed orders",
      icon: ShoppingCart,
      gradient: "gradient-accent",
      onClick: () => navigate("/sales"),
    },
    {
      title: "Revenue",
      value: `₱${totalRevenue.toLocaleString()}`,
      description: "all orders",
      icon: DollarSign,
      gradient: "gradient-primary",
      onClick: () => navigate("/sales"),
    },
    {
      title: "Growth",
      value: `${growth > 0 ? '+' : ''}${growth}%`,
      description: "recent vs older",
      icon: TrendingUp,
      gradient: "gradient-accent",
      onClick: () => navigate("/sales"),
    },
  ];

  // Get recent sales (latest 4)
  const recentSales = sales.slice(0, 4);

  // Get low stock items (quantity < 15)
  const lowStock = inventory.filter(item => item.quantity < 15);

  // Filter sales for search
  const filteredSales = useMemo(() => {
    if (!searchQuery) return recentSales;
    const query = searchQuery.toLowerCase();
    return recentSales.filter(sale => 
      sale.customer.toLowerCase().includes(query) ||
      sale.item.toLowerCase().includes(query) ||
      sale.orderId.toLowerCase().includes(query)
    );
  }, [searchQuery, sales]);

  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-400 bg-clip-text text-transparent">
          Dashboard
        </h1>
        <p className="text-muted-foreground mt-2">
          Welcome back! Here's your tailoring business overview.
        </p>
      </div>

      {/* Stats Grid */}
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

      <div className="grid gap-6 lg:grid-cols-2">
        {/* Recent Sales */}
        <Card className="shadow-card">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <ShoppingCart className="h-5 w-5 text-primary" />
              Recent Sales
            </CardTitle>
            <div className="relative mt-4">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="Search sales..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-10"
              />
            </div>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {filteredSales.length > 0 ? (
                filteredSales.map((sale) => (
                  <div 
                    key={sale.id} 
                    className="flex items-center justify-between py-3 border-b last:border-0 cursor-pointer hover:bg-muted/50 rounded-lg px-2 transition-colors"
                    onClick={() => navigate("/sales")}
                  >
                    <div>
                      <p className="font-medium">{sale.customer}</p>
                      <p className="text-sm text-muted-foreground">{sale.item}</p>
                    </div>
                    <div className="text-right">
                      <p className="font-semibold text-primary">₱{sale.amount.toLocaleString()}</p>
                      <p className="text-xs text-muted-foreground">{sale.date}</p>
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-sm text-muted-foreground text-center py-4">No sales found</p>
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
