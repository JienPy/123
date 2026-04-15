import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger,
} from "@/components/ui/dialog";
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from "@/components/ui/select";
import {
  Popover, PopoverContent, PopoverTrigger,
} from "@/components/ui/popover";
import {
  Command, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList,
} from "@/components/ui/command";
import { Plus, Edit, Trash2, Truck, ChevronDown, X, Loader2 } from "lucide-react";
import { toast } from "sonner";
import {
  fetchShippingZones,
  createShippingZone,
  updateShippingZone,
  deleteShippingZone,
  ShippingZone,
} from "@/services/directus";
import {
  getProvinces,
  getCitiesForProvince,
  Province,
  CityMunicipality,
} from "@/services/psgcApi";

// ─── MultiSelect Combobox ────────────────────────────────────────────────────

interface Option { code: string; name: string; }

function MultiSelectCombobox({
  label,
  placeholder,
  options,
  selected,
  loading,
  disabled,
  onAdd,
  onRemove,
}: {
  label: string;
  placeholder: string;
  options: Option[];
  selected: string[];
  loading?: boolean;
  disabled?: boolean;
  onAdd: (name: string) => void;
  onRemove: (name: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');

  const filtered = options.filter(
    (o) =>
      o.name.toLowerCase().includes(query.toLowerCase()) &&
      !selected.includes(o.name)
  );

  return (
    <div className="space-y-2">
      <Label>{label}</Label>
      {selected.length > 0 && (
        <div className="flex flex-wrap gap-1.5">
          {selected.map((name) => (
            <span
              key={name}
              className="inline-flex items-center gap-1 px-2 py-1 text-xs rounded-full bg-primary/10 text-primary border border-primary/20"
            >
              {name}
              <button
                type="button"
                onClick={() => onRemove(name)}
                className="hover:text-destructive ml-0.5"
              >
                <X className="w-3 h-3" />
              </button>
            </span>
          ))}
        </div>
      )}
      <Popover open={open && !disabled} onOpenChange={(o) => { if (!disabled) setOpen(o); }}>
        <PopoverTrigger asChild>
          <Button
            type="button"
            variant="outline"
            disabled={disabled}
            className="w-full justify-between font-normal text-muted-foreground"
          >
            <span>{placeholder}</span>
            {loading ? (
              <Loader2 className="h-4 w-4 animate-spin opacity-50" />
            ) : (
              <ChevronDown className="h-4 w-4 opacity-50" />
            )}
          </Button>
        </PopoverTrigger>
        <PopoverContent className="p-0 w-[--radix-popover-trigger-width]" align="start">
          <Command shouldFilter={false}>
            <CommandInput
              placeholder={`Search ${label.toLowerCase()}...`}
              value={query}
              onValueChange={setQuery}
            />
            <CommandList>
              {loading ? (
                <CommandEmpty>Loading...</CommandEmpty>
              ) : filtered.length === 0 ? (
                <CommandEmpty>No results found.</CommandEmpty>
              ) : (
                <CommandGroup>
                  {filtered.map((option) => (
                    <CommandItem
                      key={option.code}
                      value={option.name}
                      onSelect={() => {
                        onAdd(option.name);
                        setQuery('');
                        setOpen(false);
                      }}
                    >
                      {option.name}
                    </CommandItem>
                  ))}
                </CommandGroup>
              )}
            </CommandList>
          </Command>
        </PopoverContent>
      </Popover>
    </div>
  );
}

// ─── Main Component ──────────────────────────────────────────────────────────

export default function ShippingZoneSettings() {
  const [zones, setZones] = useState<ShippingZone[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [editingZone, setEditingZone] = useState<ShippingZone | null>(null);

  // PSGC data
  const [provinces, setProvinces] = useState<Province[]>([]);
  const [loadingProvinces, setLoadingProvinces] = useState(false);
  const [allCities, setAllCities] = useState<CityMunicipality[]>([]);
  const [loadingCities, setLoadingCities] = useState(false);

  // Multi-select state
  const [selectedProvinces, setSelectedProvinces] = useState<string[]>([]);
  const [selectedCities, setSelectedCities] = useState<string[]>([]);

  const [formData, setFormData] = useState({
    zone_name: "",
    fee: "",
    is_default: false,
    status: "active" as "active" | "inactive",
  });

  // Load provinces once on mount
  useEffect(() => {
    setLoadingProvinces(true);
    getProvinces()
      .then(setProvinces)
      .catch(() => toast.error("Failed to load provinces"))
      .finally(() => setLoadingProvinces(false));
  }, []);

  // Load cities whenever selected provinces change
  useEffect(() => {
    if (selectedProvinces.length === 0) {
      setAllCities([]);
      return;
    }
    setLoadingCities(true);
    const codes = selectedProvinces
      .map((name) => provinces.find((p) => p.name === name)?.code)
      .filter(Boolean) as string[];

    Promise.all(codes.map((code) => getCitiesForProvince(code)))
      .then((results) => {
        const combined = results.flat();
        const seen = new Set<string>();
        const unique = combined.filter((c) => {
          if (seen.has(c.code)) return false;
          seen.add(c.code);
          return true;
        });
        setAllCities(unique.sort((a, b) => a.name.localeCompare(b.name)));
      })
      .catch(() => toast.error("Failed to load cities"))
      .finally(() => setLoadingCities(false));
  }, [selectedProvinces, provinces]);

  useEffect(() => {
    loadZones();
  }, []);

  const loadZones = async () => {
    try {
      setIsLoading(true);
      const data = await fetchShippingZones();
      setZones(data);
    } catch {
      toast.error("Failed to load shipping zones");
    } finally {
      setIsLoading(false);
    }
  };

  const resetForm = () => {
    setFormData({ zone_name: "", fee: "", is_default: false, status: "active" });
    setSelectedProvinces([]);
    setSelectedCities([]);
    setEditingZone(null);
  };

  const handleOpenDialog = (zone?: ShippingZone) => {
    if (zone) {
      setEditingZone(zone);
      setFormData({
        zone_name: zone.zone_name,
        fee: zone.fee.toString(),
        is_default: zone.is_default,
        status: zone.status,
      });
      setSelectedProvinces(
        zone.provinces ? zone.provinces.split(',').map((s) => s.trim()).filter(Boolean) : []
      );
      setSelectedCities(
        zone.cities ? zone.cities.split(',').map((s) => s.trim()).filter(Boolean) : []
      );
    } else {
      resetForm();
    }
    setIsOpen(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.zone_name.trim() || !formData.fee) {
      toast.error("Zone name and fee are required");
      return;
    }
    setIsSubmitting(true);

    const payload = {
      zone_name: formData.zone_name,
      fee: Number(formData.fee),
      provinces: selectedProvinces.join(', '),
      cities: selectedCities.join(', '),
      is_default: formData.is_default,
      status: formData.status,
    };

    try {
      if (editingZone) {
        const updated = await updateShippingZone(editingZone.id, payload);
        setZones((prev) => prev.map((z) => (z.id === editingZone.id ? updated : z)));
        toast.success("Shipping zone updated");
      } else {
        const created = await createShippingZone(payload);
        setZones((prev) => [created, ...prev]);
        toast.success("Shipping zone created");
      }
      setIsOpen(false);
      resetForm();
    } catch {
      toast.error(editingZone ? "Failed to update zone" : "Failed to create zone");
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure you want to delete this shipping zone?")) return;
    try {
      await deleteShippingZone(id);
      setZones((prev) => prev.filter((z) => z.id !== id));
      toast.success("Shipping zone deleted");
    } catch {
      toast.error("Failed to delete shipping zone");
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-400 bg-clip-text text-transparent">
            Shipping Zones
          </h1>
          <p className="text-muted-foreground mt-2">
            Manage shipping fees by location zone
          </p>
        </div>
        <Dialog open={isOpen} onOpenChange={(open) => { setIsOpen(open); if (!open) resetForm(); }}>
          <DialogTrigger asChild>
            <Button className="shadow-lg" onClick={() => handleOpenDialog()}>
              <Plus className="h-4 w-4 mr-2" />
              Add Zone
            </Button>
          </DialogTrigger>
          <DialogContent className="max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{editingZone ? "Edit Shipping Zone" : "Add Shipping Zone"}</DialogTitle>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="zone_name">Zone Name</Label>
                <Input
                  id="zone_name"
                  placeholder="e.g., Local (Tayabas), Luzon, Visayas"
                  value={formData.zone_name}
                  onChange={(e) => setFormData({ ...formData, zone_name: e.target.value })}
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="fee">Shipping Fee (₱)</Label>
                <Input
                  id="fee"
                  type="number"
                  min="0"
                  step="0.01"
                  placeholder="e.g., 50"
                  value={formData.fee}
                  onChange={(e) => setFormData({ ...formData, fee: e.target.value })}
                  required
                />
              </div>

              {/* Province Multi-Select */}
              <MultiSelectCombobox
                label="Provinces"
                placeholder="Select province..."
                options={provinces}
                selected={selectedProvinces}
                loading={loadingProvinces}
                onAdd={(name) => setSelectedProvinces((prev) => [...prev, name])}
                onRemove={(name) => {
                  setSelectedProvinces((prev) => prev.filter((p) => p !== name));
                  // Remove cities that belong to the removed province from selected
                  // (we can't easily check this, so just keep them — they still work for matching)
                }}
              />
              <p className="text-xs text-muted-foreground -mt-1">
                Select provinces to cover. Cities below are filtered by selected province(s).
              </p>

              {/* City Multi-Select */}
              <MultiSelectCombobox
                label="Cities / Municipalities"
                placeholder={
                  selectedProvinces.length === 0
                    ? "Select a province first"
                    : "Select city / municipality..."
                }
                options={allCities}
                selected={selectedCities}
                loading={loadingCities}
                disabled={selectedProvinces.length === 0}
                onAdd={(name) => setSelectedCities((prev) => [...prev, name])}
                onRemove={(name) => setSelectedCities((prev) => prev.filter((c) => c !== name))}
              />
              <p className="text-xs text-muted-foreground -mt-1">
                Cities are matched first (higher priority than province).
              </p>

              <div className="flex items-center justify-between">
                <div>
                  <Label>Default Zone</Label>
                  <p className="text-xs text-muted-foreground">Use when no other zone matches</p>
                </div>
                <Switch
                  checked={formData.is_default}
                  onCheckedChange={(checked) => setFormData({ ...formData, is_default: checked })}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="status">Status</Label>
                <Select
                  value={formData.status}
                  onValueChange={(value: "active" | "inactive") => setFormData({ ...formData, status: value })}
                >
                  <SelectTrigger><SelectValue placeholder="Select status" /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="active">Active</SelectItem>
                    <SelectItem value="inactive">Inactive</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button type="submit" className="w-full" disabled={isSubmitting}>
                {isSubmitting ? "Saving..." : editingZone ? "Update Zone" : "Add Zone"}
              </Button>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <Card className="shadow-card">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Truck className="h-5 w-5 text-primary" />
            All Shipping Zones
          </CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Zone</TableHead>
                <TableHead>Fee</TableHead>
                <TableHead>Provinces</TableHead>
                <TableHead>Cities</TableHead>
                <TableHead>Default</TableHead>
                <TableHead>Status</TableHead>
                <TableHead className="text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={7} className="text-center py-8 text-muted-foreground">Loading...</TableCell>
                </TableRow>
              ) : zones.length > 0 ? (
                zones.map((zone) => (
                  <TableRow key={zone.id}>
                    <TableCell className="font-medium">{zone.zone_name}</TableCell>
                    <TableCell className="font-semibold text-primary">₱{zone.fee.toLocaleString()}</TableCell>
                    <TableCell className="text-muted-foreground max-w-[200px] truncate">
                      {zone.provinces || <span className="italic">—</span>}
                    </TableCell>
                    <TableCell className="text-muted-foreground max-w-[200px] truncate">
                      {zone.cities || <span className="italic">—</span>}
                    </TableCell>
                    <TableCell>
                      {zone.is_default && (
                        <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
                          Default
                        </span>
                      )}
                    </TableCell>
                    <TableCell>
                      <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${
                        zone.status === "active" ? "bg-green-100 text-green-700" : "bg-gray-100 text-gray-700"
                      }`}>
                        {zone.status}
                      </span>
                    </TableCell>
                    <TableCell className="text-right">
                      <div className="flex justify-end gap-2">
                        <Button variant="ghost" size="icon" onClick={() => handleOpenDialog(zone)}>
                          <Edit className="h-4 w-4" />
                        </Button>
                        <Button variant="ghost" size="icon" onClick={() => handleDelete(zone.id)}>
                          <Trash2 className="h-4 w-4 text-destructive" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell colSpan={7} className="text-center py-8 text-muted-foreground">No shipping zones found</TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
