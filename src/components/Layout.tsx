import { useState, useEffect, useRef } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { Home, Package, ClipboardList, ShoppingCart, Scissors, Settings, Tag, Ruler, ChevronDown, Bell } from "lucide-react";
import { cn } from "@/lib/utils";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { useData } from "@/contexts/DataContext";
import { toast } from "sonner";

interface LayoutProps {
  children: React.ReactNode;
}

const navigation = [
  { name: "Dashboard", href: "/", icon: Home },
  { name: "Inventory", href: "/inventory", icon: Package },
  { name: "Orders", href: "/orders", icon: ClipboardList },
  { name: "Sales", href: "/sales", icon: ShoppingCart },
];

const recordManagementItems = [
  { name: "Category Settings", href: "/settings/categories", icon: Tag },
  { name: "Unit Settings", href: "/settings/units", icon: Ruler },
];

export function Layout({ children }: LayoutProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { orders, refreshOrders } = useData();
  const [isRecordManagementOpen, setIsRecordManagementOpen] = useState(
    location.pathname.startsWith("/settings")
  );

  const isRecordManagementActive = recordManagementItems.some(
    (item) => location.pathname === item.href
  );

  const prevOrderCountRef = useRef<number>(orders.length);
  const [newOrderCount, setNewOrderCount] = useState(0);

  // Poll for new orders every 30 seconds
  useEffect(() => {
    const interval = setInterval(() => {
      refreshOrders();
    }, 30000);
    return () => clearInterval(interval);
  }, [refreshOrders]);

  // Detect new orders and show notification
  useEffect(() => {
    const pendingOrders = orders.filter(o => o.status === 'pending');
    const currentCount = orders.length;

    if (prevOrderCountRef.current > 0 && currentCount > prevOrderCountRef.current) {
      const newCount = currentCount - prevOrderCountRef.current;
      setNewOrderCount(prev => prev + newCount);

      const latestOrder = orders[0];
      if (latestOrder) {
        toast.info(`New order from ${latestOrder.customer_name}`, {
          description: `Order #${latestOrder.id} — ₱${parseFloat(latestOrder.total_amount).toLocaleString()}`,
          action: {
            label: "View",
            onClick: () => navigate("/orders"),
          },
          duration: 8000,
        });
      }
    }

    prevOrderCountRef.current = currentCount;
    setNewOrderCount(pendingOrders.length);
  }, [orders, navigate]);

  return (
    <div className="min-h-screen flex w-full">
      {/* Sidebar */}
      <aside className="w-64 border-r bg-card">
        <div className="h-full flex flex-col">
          {/* Logo */}
          <div className="h-16 flex items-center gap-2 px-6 border-b gradient-primary">
            <Scissors className="h-6 w-6 text-white" />
            <span className="font-semibold text-lg text-white">TailorPro</span>
          </div>

          {/* Navigation */}
          <nav className="flex-1 p-4 space-y-2">
            {navigation.map((item) => {
              const isActive = location.pathname === item.href;
              const pendingCount = item.href === "/orders" ? newOrderCount : 0;
              return (
                <Link
                  key={item.name}
                  to={item.href}
                  className={cn(
                    "flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200",
                    isActive
                      ? "bg-primary text-primary-foreground shadow-md"
                      : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  <item.icon className="h-5 w-5" />
                  <span className="font-medium flex-1">{item.name}</span>
                  {pendingCount > 0 && (
                    <span className={cn(
                      "min-w-[22px] h-[22px] px-1.5 rounded-full text-xs font-bold flex items-center justify-center",
                      isActive
                        ? "bg-primary-foreground text-primary"
                        : "bg-red-500 text-white"
                    )}>
                      {pendingCount > 99 ? '99+' : pendingCount}
                    </span>
                  )}
                </Link>
              );
            })}

            {/* Record Management Submenu */}
            <Collapsible
              open={isRecordManagementOpen}
              onOpenChange={setIsRecordManagementOpen}
            >
              <CollapsibleTrigger asChild>
                <button
                  className={cn(
                    "flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-200 w-full",
                    isRecordManagementActive
                      ? "bg-primary/10 text-primary"
                      : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  <Settings className="h-5 w-5" />
                  <span className="font-medium flex-1 text-left">Record Management</span>
                  <ChevronDown
                    className={cn(
                      "h-4 w-4 transition-transform duration-200",
                      isRecordManagementOpen && "rotate-180"
                    )}
                  />
                </button>
              </CollapsibleTrigger>
              <CollapsibleContent className="pl-4 mt-1 space-y-1">
                {recordManagementItems.map((item) => {
                  const isActive = location.pathname === item.href;
                  return (
                    <Link
                      key={item.name}
                      to={item.href}
                      className={cn(
                        "flex items-center gap-3 px-4 py-2 rounded-lg transition-all duration-200",
                        isActive
                          ? "bg-primary text-primary-foreground shadow-md"
                          : "text-muted-foreground hover:bg-muted hover:text-foreground"
                      )}
                    >
                      <item.icon className="h-4 w-4" />
                      <span className="text-sm">{item.name}</span>
                    </Link>
                  );
                })}
              </CollapsibleContent>
            </Collapsible>
          </nav>

          {/* Footer */}
          <div className="p-4 border-t text-xs text-muted-foreground text-center">
            © 2025 TailorPro
          </div>
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 overflow-auto">
        {/* Top Bar with Notification Bell */}
        <div className="sticky top-0 z-30 bg-background/80 backdrop-blur-md border-b">
          <div className="container flex items-center justify-end py-3 px-6">
            <button
              onClick={() => navigate("/orders")}
              className="relative p-2 rounded-lg hover:bg-muted transition-colors"
              title="View Orders"
            >
              <Bell className="h-5 w-5 text-muted-foreground" />
              {newOrderCount > 0 && (
                <span className="absolute -top-0.5 -right-0.5 min-w-[20px] h-5 px-1 bg-red-500 text-white text-xs font-bold rounded-full flex items-center justify-center animate-pulse">
                  {newOrderCount > 9 ? '9+' : newOrderCount}
                </span>
              )}
            </button>
          </div>
        </div>
        <div className="container py-6 px-6">
          {children}
        </div>
      </main>
    </div>
  );
}
