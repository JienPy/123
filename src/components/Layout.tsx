import { useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { Home, Package, ClipboardList, ShoppingCart, Scissors, Settings, Tag, Ruler, ChevronDown } from "lucide-react";
import { cn } from "@/lib/utils";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";

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
  const [isRecordManagementOpen, setIsRecordManagementOpen] = useState(
    location.pathname.startsWith("/settings")
  );

  const isRecordManagementActive = recordManagementItems.some(
    (item) => location.pathname === item.href
  );

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
                  <span className="font-medium">{item.name}</span>
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
        <div className="container py-8 px-6">
          {children}
        </div>
      </main>
    </div>
  );
}
